Return-Path: <linux-scsi+bounces-846-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E2380DB3F
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 21:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E550AB21527
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DF253801;
	Mon, 11 Dec 2023 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jo1gSyWK"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535C3C4
	for <linux-scsi@vger.kernel.org>; Mon, 11 Dec 2023 12:06:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dbc507311d7so3612560276.1
        for <linux-scsi@vger.kernel.org>; Mon, 11 Dec 2023 12:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702325212; x=1702930012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H/z0Ss5XFyvJoTs661LIBp6cShTF2gRz4qVPuHESwH4=;
        b=Jo1gSyWKpASbLjCcWOztaHALyapm3/+VnyckApDHpgz7xb7A/XrcStCgRaAreOnf3P
         pZDDQPIi2OeVWK7E3TAkFqY/7bgMl6OUx0B14Kh87YF/tMEoIwwE+GiqPvDarjLGeKjU
         +z+eW2EybjrRSE/NBS9BlVuE2dLjII3J/l8e3Z4qnvdIpCYXZZdn65s4hyQTod4oBPIN
         3j9vN+WCM9k/pUZhiV6ZT3XFzJRBGXlnKEZnJ20KcTOa6K7D83HfcfSk8ygUTnijak/a
         5/arALioS+gfgwo6K4zl2cY/p4Qw/RUchGhpz5PIcVOxYeF9w2Jv52wiaxbgeEMhmTho
         LBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702325212; x=1702930012;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H/z0Ss5XFyvJoTs661LIBp6cShTF2gRz4qVPuHESwH4=;
        b=jTYcGxFi3MuDP0ZNudvXRYQczK54U34J5mTSRNWLMjggZY7yuvRncRLQnyNZXucPu7
         YklPzHYmkgMg/BROgPO1CW7JEYQisnZ3VvcNs2THh/eb84TzYjJsFOkK6clT4pz7C2DO
         S8q3od7YMxd/zRNfByIZJSnvu/KJ6xIRW+/g/ypPr4MWtUC5BlT+yogjTIodfCERxWdz
         xBGL4AlzRRvmho1ckAY+fF1WFjpXmSi4NqD2ZUndMz4erDRWJLWPxbmQu87TAW6G+s1k
         JQ5Pjy6ZD94yqm049cGYIsLrUVgNydlJWfPxD5burb+02DTKaEl83vkiZpoOTDUaZVaL
         wXxA==
X-Gm-Message-State: AOJu0Yyn44WSBykyokoOTABmu9YsL5+qFpu8EDVeWSGWuCRKqx5QFtOU
	Cr9oecpRC2CUkKZ0mErwle4BWsGZ1GwLveoA5w==
X-Google-Smtp-Source: AGHT+IHi7DG+3EuXdHK5kIVsRK1zQwJY0+cr+9QAn+IL/5jWC8TAFEd1H552VSUKLgOSUkaLfOFRXQZzJtR7rQmH7g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:f803:0:b0:db4:868a:7fdd with SMTP
 id u3-20020a25f803000000b00db4868a7fddmr34903ybd.7.1702325212490; Mon, 11 Dec
 2023 12:06:52 -0800 (PST)
Date: Mon, 11 Dec 2023 20:06:28 +0000
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMNrd2UC/5WNUQqDMBBEryL73S1JrEX61XuIlJJsdKE1siuhI
 t69qTcoAwNvPuZtoCRMCrdqA6HMymkqYE8V+PE5DYQcCoMzrrbGXVAXmfy8YhDOJIrqlTH6REc
 9dNWo6NGQDTFS69qmgXI2C0X+HKKuLzyyLknWw5vtb/1bkS2WkDHuSmRqF+5DSsOLzj69od/3/ Qv/yJDj3QAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702325211; l=3841;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=rZMZkomkudUsfqwyDRixYeQW5ARfhWOfNshuF+j5KFg=; b=Khn6RMul5mGMMQgX2HtgBJxmEdbICK7Jkloq1RCDq5aClSb8YlhOXhAz7X788sUUloB6KKHOb
 M7IWjerhyGaAgjLX9/wWgqCslM9+SytVUD3iI6vuPVwT1wgAbEIEk0V
X-Mailer: b4 0.12.3
Message-ID: <20231211-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v1-1-73b942238396@google.com>
Subject: [PATCH] scsi: fcoe: use sysfs_match_string over fcoe_parse_mode
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
sysfs_match_string can return -EINVAL.

To get the compiler not to complain, make fip_conn_type_names
const char * const. Perhaps, this should also be done for
fcf_state_names.

This also removes an instance of strncpy() which helps [1].

Link: https://github.com/KSPP/linux/issues/90 [1]
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Builds upon patch and feedback from [2]:

However, this is different enough to warrant its own patch and not be a
continuation.

[2]: https://lore.kernel.org/all/9f38f4aa-c6b5-4786-a641-d02d8bd92f7f@acm.org/
---
 drivers/scsi/fcoe/fcoe_sysfs.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index e17957f8085c..f9c5d00f658a 100644
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
+		if (ctlr->mode < 0) {
 			LIBFCOE_SYSFS_DBG(ctlr, "Unknown mode %s provided.\n",
 					  buf);
 			return -EINVAL;

---
base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
change-id: 20231024-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-0e1dffe82855

Best regards,
--
Justin Stitt <justinstitt@google.com>


