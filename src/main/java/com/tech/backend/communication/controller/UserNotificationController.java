package com.tech.backend.communication.controller;

import com.tech.backend.communication.common.BadRequestException;
import com.tech.backend.communication.model.response.CountAllNotificationResponse;
import com.tech.backend.communication.model.response.RestResult;
import com.tech.backend.communication.model.response.UserNotificationDto;
import com.tech.backend.communication.service.UserNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.PermissionDeniedDataAccessException;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author nguyen.tam.thi at 15:16 2020-04-21
 */
@RestController
@RequestMapping("/user-notifications")
public class UserNotificationController extends BaseController {

    @Autowired
    private UserNotificationService userNotificationService;

    @GetMapping("/mine")
    public ResponseEntity<RestResult<Page<UserNotificationDto>>> getMyNotifications(
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "20") Integer limit,
            @RequestParam(required = false) List<String> types
    ) {
        RestResult result = new RestResult<>();
        result.setStatus(RestResult.STATUS_SUCCESS);
        result.setMessage("Get my notifications successfully");
        result.setData(userNotificationService.getUserNotificationsByProfileId(getProfileId(), types, page, limit));
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @GetMapping("/system")
    public ResponseEntity<RestResult<Page<UserNotificationDto>>> getSystemNotifications(
            @RequestHeader("Tenant-Id") String tenantId,
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "20") Integer limit,
            @RequestParam(required = false) List<String> types
    ) {
        RestResult result = new RestResult<>();
        result.setStatus(RestResult.STATUS_SUCCESS);
        result.setMessage("Get system notifications successfully");
        result.setData(userNotificationService.getSystemNotifications(tenantId, types, page, limit));
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @PostMapping("/mark-read/{notificationId}")
    public ResponseEntity<RestResult<Void>> markRead(@PathVariable Long notificationId) {
        userNotificationService.markRead(notificationId);
        RestResult result = new RestResult<>();
        result.setStatus(RestResult.STATUS_SUCCESS);
        result.setMessage("Mark notification read successfully");
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @GetMapping("/count-all")
    public ResponseEntity<RestResult<CountAllNotificationResponse>> countAll(
            @RequestHeader("Tenant-Id") String tenantId
    ) {
        RestResult result = new RestResult<>();
        result.setStatus(RestResult.STATUS_SUCCESS);
        result.setMessage("Count all notifications successfully");
        CountAllNotificationResponse response = new CountAllNotificationResponse();
        response.setNumber(userNotificationService.countAllNotificationsByProfileId(tenantId, getProfileId()));
        result.setData(response);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @DeleteMapping("/{notificationId}")
    public ResponseEntity<RestResult<Void>> delete(
            @PathVariable Long notificationId
    ) {
        userNotificationService.delete(getProfileId(), notificationId);
        RestResult result = new RestResult<>();
        result.setStatus(RestResult.STATUS_SUCCESS);
        result.setMessage("Delete notification successfully");
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @DeleteMapping("/system/{notificationId}")
    public ResponseEntity<RestResult<Void>> deleteSystemNotification(
            @PathVariable Long notificationId
    ) {
        if (getProfileType().equals("ADMIN")) {
            userNotificationService.deleteSystemNotification(notificationId);
        } else {
            throw new BadRequestException("Permission denied");
        }
        RestResult result = new RestResult<>();
        result.setStatus(RestResult.STATUS_SUCCESS);
        result.setMessage("Delete notification successfully");
        return new ResponseEntity<>(result, HttpStatus.OK);
    }
}
