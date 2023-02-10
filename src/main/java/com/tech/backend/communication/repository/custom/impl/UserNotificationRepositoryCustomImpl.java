package com.tech.backend.communication.repository.custom.impl;

import com.tech.backend.communication.model.entity.UserNotification;
import com.tech.backend.communication.repository.BaseRepository;
import com.tech.backend.communication.repository.custom.UserNotificationRepositoryCustom;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import javax.persistence.Query;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

/**
 * @author nguyen.tam.thi at 13:47 2020-06-26
 */
public class UserNotificationRepositoryCustomImpl extends BaseRepository implements UserNotificationRepositoryCustom {

    @Override
    public Page<UserNotification> filter(String tenantId, Long profileId, List<String> types, Pageable pageable) {
        Query countQuery = createFilterQuery(tenantId, profileId, types, pageable, true);
        Long total = ((BigInteger) countQuery.getSingleResult()).longValue();
        if (total == 0) {
            Page<UserNotification> page = new PageImpl(new ArrayList<>(), pageable, total.intValue());
            return page;
        } else {
            Query query = createFilterQuery(tenantId, profileId, types, pageable, false);
            List<UserNotification> results = query.getResultList();
            Page<UserNotification> page = new PageImpl(results, pageable, total.intValue());
            return page;
        }
    }

    private Query createFilterQuery(String tenantId, Long profileId, List<String> types, Pageable pageable, boolean isCount) {
        StringBuilder sql = new StringBuilder();
        if (isCount) {
            sql.append("SELECT COUNT(*) ");
        } else {
            sql.append("SELECT u.* ");
        }
        sql.append("FROM user_notification u ");
        List<String> whereQuery = new ArrayList<>();
        if (tenantId != null) {
            whereQuery.add("u.tenant_id = :tenantId ");
        }
        if (profileId != null) {
            whereQuery.add("u.profile_id = :profileId ");
        } else {
            whereQuery.add("u.profile_id is null ");
        }
        if (types != null && !types.isEmpty()) {
            whereQuery.add("u.type in :types ");
        }
        if (!whereQuery.isEmpty()) {
            sql.append("where ");
            sql.append(String.join("and ", whereQuery));
        }
        if (!isCount) {
            appendSortQuery(pageable, sql);
        }
        Query query;
        if (!isCount) {
            query = entityManager.createNativeQuery(sql.toString(), UserNotification.class);
        } else {
            query = entityManager.createNativeQuery(sql.toString());
        }
        if (tenantId != null) {
            query.setParameter("tenantId", tenantId);
        }
        if (profileId != null) {
            query.setParameter("profileId", profileId);
        }
        if (types != null && !types.isEmpty()) {
            query.setParameter("types", types);
        }
        if (!isCount) {
            appendPageQuery(pageable, query);
        }
        return query;
    }
}
