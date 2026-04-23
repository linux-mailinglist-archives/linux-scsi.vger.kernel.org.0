Return-Path: <linux-scsi+bounces-23235-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK34Nj7V6WnxlAIAu9opvQ
	(envelope-from <linux-scsi+bounces-23235-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 10:15:58 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6DD44E686
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 10:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9AD2301ABAA
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CE5366558;
	Thu, 23 Apr 2026 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtRJAaRx"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F92365A14
	for <linux-scsi@vger.kernel.org>; Thu, 23 Apr 2026 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776932119; cv=none; b=DElTm5teh4dVSlAqGhBpVx2DhO+ziFPn4cu1fG671XMfzEAsGxIrKroYBC35lFopOQ/hXVJgNrm7u7DqFdVpetYsIAR7n9Sy3r1dbixn2CbwVautF97eTVlHnGNTnsN0Gd7Gfx+89w1489IcWV54frAlV7cb8b5tl/0+LIRHTUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776932119; c=relaxed/simple;
	bh=RU8UHEcMDQ31+XMhZweZWyi85Cawfhiz9/q0WEBa9iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p45ixcaEXuIalihcEx1LRQu4JISq2cHsLFt7U53/Nr6UUEyAqSM20iPTmPQz9U7Zj7wbIaf0W4CHpjMxG/i4iIcvaAexbJUi4V2+6IUz4rkdKAgRUHnbA4z2ISSy5BJXxarWTAvLaJVgwpJcMngPH/9Or8EpFfhzki+ptXPsp/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtRJAaRx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6720c7968e4so739940a12.0
        for <linux-scsi@vger.kernel.org>; Thu, 23 Apr 2026 01:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776932116; x=1777536916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3K8BbI4kqqDT2uTdEJ7DYsFUVLuW/rEWVHIXnjPkzVU=;
        b=AtRJAaRxP5GUSRZL7x4rYPBmpZ4LVTujsa6iNyCs2glVi/XWlns8XWDHfhsqRQNTyN
         YXfQcxQEOuGyWacuic6IG8E8+ujwMsyxugIyBFF+y8xIo+OuK2ssDtiMD6WYwXV5w0DE
         92uODZgKxAjFDwMm9Dl+8bSuONcjO1hTe6d7cvSslAz6IVtKtgN896Olal+y8fbqWlUE
         jxZYZOrqccIrbSQ8slWZdR1BVmFIcT6BHKyRAXQZ2kYIQg6NysKKHVkBTkyKIS+7eXMy
         n0aOirw4RYK7y2pn/x7cw5DVmB6/g7bHGamyqD/fYfRqIwMgUpmROe4jWEGARH6NXfvC
         J7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776932116; x=1777536916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K8BbI4kqqDT2uTdEJ7DYsFUVLuW/rEWVHIXnjPkzVU=;
        b=WNx0POXdHcTW0NmZVFg0Q+DMIiIwhQWaUEA5sUK0od3gRh6di7h3Sq8oSMdLKisPwl
         3FhQmIccRWNN3KQv9gInwkqk5XrjsA9QrthNoPvrYwliqAxqQclCDm24JPgj3fvxanEN
         HHIY8cP+VDSpbJ9vZBkfFGiBbAVnVpaxfscb0qOaqMPtSbz3WyyKr6SCeq81KBPoorF7
         ijvVb6moLwfPeTL6P9oDbqGdpWDW3/TkQNtutWXPZEND20mFrkoGgOaAGrq4PNzGSUz+
         0v/O40fZyd7c4uWhJl/vnsVs9dxXRrUgYMKIWyY/B7GYJUzC4gR40mEkuvkr20kEY3Yd
         xYOw==
X-Gm-Message-State: AOJu0Yy4yq0Nflz+VMYdPKSK+7W04+6iKw/m43wFmRfF1E3zZMHMB7gH
	/C0iazP/dRbvJc4ZpnlyOrOgsrADpOt0iaxOD2wnNIpY+E5mtIWDuOcD
X-Gm-Gg: AeBDiessqjth8PKCGFqmHstm10AcwkYGMes3IzIV3KirCX9f+rcq09I2wm6cOLPv6iM
	yLkwyY5WL/2otc0AKuWtVsrKL10kwS7UbbGACIDaQid+dbVx/fhhVREckulCD04Ia3L8qh0xoLK
	aUNOH9VARiz1l4Z+qKA/hx0LjSub6DSFHzR45L/8nZFjfPK//vxzrI9eKTGa+QUrGW2KV0En/cz
	n4XbB5jMJ10Vz4YH4d2UxKtkWtw7mS6oNmbbOm/CYxL0Fg/mygIngfkqw5I9CP0/4Cznld1LGN3
	cRZLqOl9/s6ybkJAGm45OPnUjcDW8IuCkHTiZIahruaDYhipQxFQL0xpTQm1XxtSvLysi8F/ZI+
	GWW+fcZBHWEtf8BG5XQ0q/n8i3rYNqMxx7HuOKabcYZGgiVRJvoz8u3QJDfrQgiyNaMZTKsE0V+
	De6G7R7qUS/HZQO08Y0u0bJH/ZleU5bR4nbUdhO+yWkVPm1LRysXFPidA7vSP1gthmCbbtvWCIu
	Vaq1Okh78PEvQNDc+RzVLwgyHaFpgdJBCRLnw==
X-Received: by 2002:a05:6402:440b:b0:677:1cce:54af with SMTP id 4fb4d7f45d1cf-6771cce5812mr2125371a12.13.1776932116061;
        Thu, 23 Apr 2026 01:15:16 -0700 (PDT)
Received: from arch-piotr.tailb7ebba.ts.net (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6744dcdf29fsm3332962a12.30.2026.04.23.01.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:15:15 -0700 (PDT)
From: Piotr Zarycki <piotr.zarycki@gmail.com>
To: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Piotr Zarycki <piotr.zarycki@gmail.com>
Subject: [PATCH] scsi: isci: remove unused macro scu_get_command_request_logical_port
Date: Thu, 23 Apr 2026 10:13:43 +0200
Message-ID: <20260423081343.1813002-1-piotr.zarycki@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23235-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[piotrzarycki@gmail.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F6DD44E686
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The macro scu_get_command_request_logical_port() has never been used
since it was introduced.

Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
---
 drivers/scsi/isci/scu_task_context.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/isci/scu_task_context.h b/drivers/scsi/isci/scu_task_context.h
index 9cb4f5e30b86..40306c054117 100644
--- a/drivers/scsi/isci/scu_task_context.h
+++ b/drivers/scsi/isci/scu_task_context.h
@@ -211,8 +211,6 @@ typedef enum {
 
 #define SCU_CONTEXT_COMMAND_LOGICAL_PORT_SHIFT           12
 #define SCU_CONTEXT_COMMAND_LOGICAL_PORT_MASK            0x00007000
-#define scu_get_command_request_logical_port(x)	\
-	((x) & SCU_CONTEXT_COMMAND_LOGICAL_PORT_MASK)
 
 
 #define MAKE_SCU_CONTEXT_COMMAND_TYPE(type) \
-- 
2.53.0


