package com.matrix.commonservice.extra.table.sql;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import org.hibernate.dialect.Dialect;
import org.hibernate.type.LiteralType;
import org.hibernate.util.StringHelper;

public class Update {
    private String tableName;
    private String[] primaryKeyColumnNames;
    private String versionColumnName;
    private String where;
    private String assignments;
    private String comment;
    private Map columns = new LinkedHashMap();
    private Map whereColumns = new LinkedHashMap();
    private Dialect dialect;

    public Update(Dialect dialect) {
        this.dialect = dialect;
    }

    public String getTableName() {
        return this.tableName;
    }

    public Update appendAssignmentFragment(String fragment) {
        if (this.assignments == null) {
            this.assignments = fragment;
        } else {
            this.assignments = this.assignments + ", " + fragment;
        }

        return this;
    }

    public Update setTableName(String tableName) {
        this.tableName = tableName;
        return this;
    }

    public Update setPrimaryKeyColumnNames(String[] primaryKeyColumnNames) {
        this.primaryKeyColumnNames = primaryKeyColumnNames;
        return this;
    }

    public Update setVersionColumnName(String versionColumnName) {
        this.versionColumnName = versionColumnName;
        return this;
    }

    public Update setComment(String comment) {
        this.comment = comment;
        return this;
    }

    public Update addColumns(String[] columnNames) {
        for(int i = 0; i < columnNames.length; ++i) {
            this.addColumn(columnNames[i]);
        }

        return this;
    }

    public Update addColumns(String[] columnNames, boolean[] updateable) {
        for(int i = 0; i < columnNames.length; ++i) {
            if (updateable[i]) {
                this.addColumn(columnNames[i]);
            }
        }

        return this;
    }

    public Update addColumns(String[] columnNames, String value) {
        for(int i = 0; i < columnNames.length; ++i) {
            this.addColumn(columnNames[i], value);
        }

        return this;
    }

    public Update addColumn(String columnName) {
        return this.addColumn(columnName, "?");
    }

    public Update addColumn(String columnName, String value) {
        this.columns.put(columnName, value);
        return this;
    }

    public Update addColumn(String columnName, Object value, LiteralType type) throws Exception {
        return this.addColumn(columnName, type.objectToSQLString(value, this.dialect));
    }

    public Update addWhereColumns(String[] columnNames) {
        for(int i = 0; i < columnNames.length; ++i) {
            this.addWhereColumn(columnNames[i]);
        }

        return this;
    }

    public Update addWhereColumns(String[] columnNames, String value) {
        for(int i = 0; i < columnNames.length; ++i) {
            this.addWhereColumn(columnNames[i], value);
        }

        return this;
    }

    public Update addWhereColumn(String columnName) {
        return this.addWhereColumn(columnName, "=?");
    }

    public Update addWhereColumn(String columnName, String value) {
        this.whereColumns.put(columnName, value);
        return this;
    }

    public Update setWhere(String where) {
        this.where = where;
        return this;
    }

    public String toStatementString() {
        StringBuffer buf = new StringBuffer(this.columns.size() * 15 + this.tableName.length() + 10);
        if (this.comment != null) {
            buf.append("/* ").append(this.comment).append(" */ ");
        }

        buf.append("update ").append(this.tableName).append(" set ");
        boolean assignmentsAppended = false;

        Iterator iter;
        for(iter = this.columns.entrySet().iterator(); iter.hasNext(); assignmentsAppended = true) {
            Map.Entry e = (Map.Entry)iter.next();
            buf.append(e.getKey()).append('=').append(e.getValue());
            if (iter.hasNext()) {
                buf.append(", ");
            }
        }

        if (this.assignments != null) {
            if (assignmentsAppended) {
                buf.append(", ");
            }

            buf.append(this.assignments);
        }

        boolean conditionsAppended = false;
        if (this.primaryKeyColumnNames != null || this.where != null || !this.whereColumns.isEmpty() || this.versionColumnName != null) {
            buf.append(" where ");
        }

        if (this.primaryKeyColumnNames != null) {
            buf.append(StringHelper.join("=? and ", this.primaryKeyColumnNames)).append("=?");
            conditionsAppended = true;
        }

        if (this.where != null) {
            if (conditionsAppended) {
                buf.append(" and ");
            }

            buf.append(this.where);
            conditionsAppended = true;
        }

        for(iter = this.whereColumns.entrySet().iterator(); iter.hasNext(); conditionsAppended = true) {
            Map.Entry e = (Map.Entry)iter.next();
            if (conditionsAppended) {
                buf.append(" and ");
            }

            buf.append(e.getKey()).append(e.getValue());
        }

        if (this.versionColumnName != null) {
            if (conditionsAppended) {
                buf.append(" and ");
            }

            buf.append(this.versionColumnName).append("=?");
        }

        return buf.toString();
    }
}
