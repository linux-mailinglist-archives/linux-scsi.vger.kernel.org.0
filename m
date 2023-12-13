Return-Path: <linux-scsi+bounces-905-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B7380FB3A
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Dec 2023 00:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21831C20D9D
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Dec 2023 23:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363916472B;
	Tue, 12 Dec 2023 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0IgtaJB"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1BDEA
	for <linux-scsi@vger.kernel.org>; Tue, 12 Dec 2023 15:19:08 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5e16d7537bcso24933257b3.3
        for <linux-scsi@vger.kernel.org>; Tue, 12 Dec 2023 15:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702423147; x=1703027947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/YmSdHW0YnrgQyxCZCfpHUpcVYgfb1QxvP3xvZamGAg=;
        b=T0IgtaJB2ly20lZB2MHikNj+HcKJKO2+Y6NXtlLuNyFF92RdVOXjPx9PkOldabIBAK
         herFA6ZFzq6TMmaMoD9o1UlnuqdefWd8dSE5qdgswnzGNrIpMpOyY+bWMXl3+lJ8oM39
         3ZE8UA6zhINly1tf364Ju+LLyMXdRBfJwyRiOpq3Su67n3rr1PZiwM5bk5tYdB5AfBFN
         z/2slIL/OcmfcHIvcW3BGU3HyVrWx9S+Fnc+PHbbs/zdFYqaMUdqkoULagpXmKz6O9Vx
         gzBjacsWZsoJz98N7xd0qLeluBvd/58qLCXYD7YOOcKnZVY+g0QajHnDGzPslWJ14T+h
         pn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423147; x=1703027947;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/YmSdHW0YnrgQyxCZCfpHUpcVYgfb1QxvP3xvZamGAg=;
        b=mcQKXKrIa6DSQAAAdCIsoJko4LaHkwXHc2OSUcsq3UgA+qgccoafYtNI8Vpk4yL386
         unh9VZEUt2YOck8/kx0zQutn1AZZF8fGdwDrek5+IcSjb312WKZv4+cpn79V8l+x+0+i
         89H4yatOCx3LqZ1UDuGJlxZcL6MTJ5IS/Uc1MtAmG6117CN0CAfzA1tBmwT4XQ6KfXDh
         I3Q5s8lW8Bx2jutee3eTgO9Iy+CDptcgTBaM5gUABm2nFFDMrcammJIOhrfKmBSQU6GG
         Z7nbavTewtbiQQMwElAfERGuPWaPXFojIIwecM6bANk0y5wYZTdoz2rIxmzfxqiGk4g4
         DkeQ==
X-Gm-Message-State: AOJu0YyuPwavCISYEusE4EWzbdE0OGrCp6FYKETtxf3uEvPYm6AiMvO9
	JFSV6zFPjDPGHkGYmQbOBS82z3B7HwekydokQA==
X-Google-Smtp-Source: AGHT+IEpLi0Rm/0x6D0ko9SJaw0nsb4I84pLyrEFP8w1pM+ISdP1wxAh6qDWor2wI6KeyuvP6T8XV9dzFXyb/rXUVQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:b8d:b0:5d4:2ff3:d280 with
 SMTP id ck13-20020a05690c0b8d00b005d42ff3d280mr63466ywb.7.1702423147099; Tue,
 12 Dec 2023 15:19:07 -0800 (PST)
Date: Tue, 12 Dec 2023 23:19:06 +0000
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGnqeGUC/5WNQQqDMBBFryJZNyWZqNWueo8ipU0mGmiNZCRUx
 Ls3ZtWtDAy8v3hvZYTBIbFrsbKA0ZHzYwI4FUwPz7FH7kxiBgKUFFBymsOop4Wb4CIG4qTJcas
 95veghSxxzQVKYy020FQVS7IpoHXfHLp3iQdHsw9L7ka5r4cTUfJ0KATUiEKBufXe9288a//Zk 9kHUh7yXdSrLQFUo9r639dt2/YDe0N+py0BAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702423146; l=4253;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=YiBU+J66ZaYx7q1aD7BISZtA4pcTkaCKnD8Tq9532Dc=; b=qaycx8xPm6Y1bhVtOlCyfrYYpwIzDp8dE+H1QlGhA1uuN5u5JDihjUla+CzhLRbk00RO80gRk
 yTiIV4l3Z3HCtuOp0xW65fVh9g+EjUXg1EuEn2oht/+IoHbtLzb70wk
X-Mailer: b4 0.12.3
Message-ID: <20231212-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v2-1-1f2d6b2fc409@google.com>
Subject: [PATCH v2] scsi: fcoe: use sysfs_match_string over fcoe_parse_mode
From: Justin Stitt <justinstitt@google.com>
To: Hannes Reinecke <hare@suse.de>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Instead of copying @buf into a new buffer and carefully managing its
newline/null-terminating status, we can just use sysfs_match_string()
as it uses sysfs_streq() internally which handles newline/null-term:

|  /**
|   * sysfs_streq - return true if strings are equal, modulo trailing newline
|   * @s1: one string
|   * @s2: another string
|   *
|   * This routine returns true iff two strings are equal, treating both
|   * NUL and newline-then-NUL as equivalent string terminations.  It's
|   * geared for use with sysfs input strings, which generally terminate
|   * with newlines but are compared against values without newlines.
|   */
|  bool sysfs_streq(const char *s1, const char *s2)
|  ...

Then entirely drop the now unused fcoe_parse_mode, being careful to
change if condition from checking for FIP_CONN_TYPE_UNKNOWN to < 0 as
sysfs_match_string can return -EINVAL. Also check explicitly if
ctlr->mode is equal to FIP_CONN_TYPE_UNKNOWN -- this is probably
preferred to "<=" as the behavior is more obvious while maintaining
functionality.

To get the compiler not to complain, make fip_conn_type_names
const char * const. Perhaps, this should also be done for
fcf_state_names.

This also removes an instance of strncpy() which helps [1].

Link: https://github.com/KSPP/linux/issues/90 [1]
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- update if-cond to check for unknown type (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20231211-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v1-1-73b942238396@google.com
---
Builds upon patch and feedback from [2]:

However, this is different enough to warrant its own patch and not be a
continuation.

[2]: https://lore.kernel.org/all/9f38f4aa-c6b5-4786-a641-d02d8bd92f7f@acm.org/
---
 drivers/scsi/fcoe/fcoe_sysfs.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index e17957f8085c..408a806bf4c2 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/etherdevice.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 #include <scsi/fcoe_sysfs.h>
 #include <scsi/libfcoe.h>
@@ -214,25 +215,13 @@ static const char *get_fcoe_##title##_name(enum table_type table_key)	\
 	return table[table_key];					\
 }
 
-static char *fip_conn_type_names[] = {
+static const char * const fip_conn_type_names[] = {
 	[ FIP_CONN_TYPE_UNKNOWN ] = "Unknown",
 	[ FIP_CONN_TYPE_FABRIC ]  = "Fabric",
 	[ FIP_CONN_TYPE_VN2VN ]   = "VN2VN",
 };
 fcoe_enum_name_search(ctlr_mode, fip_conn_type, fip_conn_type_names)
 
-static enum fip_conn_type fcoe_parse_mode(const char *buf)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(fip_conn_type_names); i++) {
-		if (strcasecmp(buf, fip_conn_type_names[i]) == 0)
-			return i;
-	}
-
-	return FIP_CONN_TYPE_UNKNOWN;
-}
-
 static char *fcf_state_names[] = {
 	[ FCOE_FCF_STATE_UNKNOWN ]      = "Unknown",
 	[ FCOE_FCF_STATE_DISCONNECTED ] = "Disconnected",
@@ -274,17 +263,10 @@ static ssize_t store_ctlr_mode(struct device *dev,
 			       const char *buf, size_t count)
 {
 	struct fcoe_ctlr_device *ctlr = dev_to_ctlr(dev);
-	char mode[FCOE_MAX_MODENAME_LEN + 1];
 
 	if (count > FCOE_MAX_MODENAME_LEN)
 		return -EINVAL;
 
-	strncpy(mode, buf, count);
-
-	if (mode[count - 1] == '\n')
-		mode[count - 1] = '\0';
-	else
-		mode[count] = '\0';
 
 	switch (ctlr->enabled) {
 	case FCOE_CTLR_ENABLED:
@@ -297,8 +279,8 @@ static ssize_t store_ctlr_mode(struct device *dev,
 			return -ENOTSUPP;
 		}
 
-		ctlr->mode = fcoe_parse_mode(mode);
-		if (ctlr->mode == FIP_CONN_TYPE_UNKNOWN) {
+		ctlr->mode = sysfs_match_string(fip_conn_type_names, buf);
+		if (ctlr->mode < 0 || ctlr->mode == FIP_CONN_TYPE_UNKNOWN) {
 			LIBFCOE_SYSFS_DBG(ctlr, "Unknown mode %s provided.\n",
 					  buf);
 			return -EINVAL;

---
base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
change-id: 20231024-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-0e1dffe82855

Best regards,
--
Justin Stitt <justinstitt@google.com>


