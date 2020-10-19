package com.matrix.commonservice.extra.table.sql;

import org.hibernate.LockMode;
import org.hibernate.dialect.Dialect;
import org.hibernate.util.StringHelper;

public class Select {
    private String selectClause;
    private String fromClause;
    private String outerJoinsAfterFrom;
    private String whereClause;
    private String outerJoinsAfterWhere;
    private String orderByClause;
    private String groupByClause;
    private String comment;
    private LockMode lockMode;
    public final Dialect dialect;
    private int guesstimatedBufferSize = 20;

    public Select(Dialect dialect) {
        this.dialect = dialect;
    }

    public String toStatementString() {
        StringBuffer buf = new StringBuffer(this.guesstimatedBufferSize);
        if (StringHelper.isNotEmpty(this.comment)) {
            buf.append("/* ").append(this.comment).append(" */ ");
        }

        buf.append("select ").append(this.selectClause).append(" from ").append(this.fromClause);
        if (StringHelper.isNotEmpty(this.outerJoinsAfterFrom)) {
            buf.append(this.outerJoinsAfterFrom);
        }

        if (StringHelper.isNotEmpty(this.whereClause) || StringHelper.isNotEmpty(this.outerJoinsAfterWhere)) {
            buf.append(" where ");
            if (StringHelper.isNotEmpty(this.outerJoinsAfterWhere)) {
                buf.append(this.outerJoinsAfterWhere);
                if (StringHelper.isNotEmpty(this.whereClause)) {
                    buf.append(" and ");
                }
            }

            if (StringHelper.isNotEmpty(this.whereClause)) {
                buf.append(this.whereClause);
            }
        }

        if (StringHelper.isNotEmpty(this.groupByClause)) {
            buf.append(" group by ").append(this.groupByClause);
        }

        if (StringHelper.isNotEmpty(this.orderByClause)) {
            buf.append(" order by ").append(this.orderByClause);
        }

        if (this.lockMode != null) {
            buf.append(this.dialect.getForUpdateString(this.lockMode));
        }

        return this.dialect.transformSelectString(buf.toString());
    }

    public Select setFromClause(String fromClause) {
        this.fromClause = fromClause;
        this.guesstimatedBufferSize += fromClause.length();
        return this;
    }

    public Select setFromClause(String tableName, String alias) {
        this.fromClause = tableName + ' ' + alias;
        this.guesstimatedBufferSize += this.fromClause.length();
        return this;
    }

    public Select setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
        this.guesstimatedBufferSize += orderByClause.length();
        return this;
    }

    public Select setGroupByClause(String groupByClause) {
        this.groupByClause = groupByClause;
        this.guesstimatedBufferSize += groupByClause.length();
        return this;
    }

    public Select setOuterJoins(String outerJoinsAfterFrom, String outerJoinsAfterWhere) {
        this.outerJoinsAfterFrom = outerJoinsAfterFrom;
        String tmpOuterJoinsAfterWhere = outerJoinsAfterWhere.trim();
        if (tmpOuterJoinsAfterWhere.startsWith("and")) {
            tmpOuterJoinsAfterWhere = tmpOuterJoinsAfterWhere.substring(4);
        }

        this.outerJoinsAfterWhere = tmpOuterJoinsAfterWhere;
        this.guesstimatedBufferSize += outerJoinsAfterFrom.length() + outerJoinsAfterWhere.length();
        return this;
    }

    public Select setSelectClause(String selectClause) {
        this.selectClause = selectClause;
        this.guesstimatedBufferSize += selectClause.length();
        return this;
    }

    public Select setWhereClause(String whereClause) {
        this.whereClause = whereClause;
        this.guesstimatedBufferSize += whereClause.length();
        return this;
    }

    public Select setComment(String comment) {
        this.comment = comment;
        this.guesstimatedBufferSize += comment.length();
        return this;
    }

    public LockMode getLockMode() {
        return this.lockMode;
    }

    public Select setLockMode(LockMode lockMode) {
        this.lockMode = lockMode;
        return this;
    }
}