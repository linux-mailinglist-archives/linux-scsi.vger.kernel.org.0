Return-Path: <linux-scsi+bounces-24255-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yVD1MXc+G2r2AQkAu9opvQ
	(envelope-from <linux-scsi+bounces-24255-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 30 May 2026 21:45:59 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3191161311E
	for <lists+linux-scsi@lfdr.de>; Sat, 30 May 2026 21:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B1BE303EC3F
	for <lists+linux-scsi@lfdr.de>; Sat, 30 May 2026 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F075233952;
	Sat, 30 May 2026 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/6dimAW"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2E1DDC1D
	for <linux-scsi@vger.kernel.org>; Sat, 30 May 2026 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780170355; cv=none; b=XrE2j84rsIPuS3LAdYvECRtB0KUghKKFuiR5jYD1293SCoQIvA6kKBN0eSQ8WHJi4sHjYIqlkigeEVDyZ5PSAEw7dnjfsvFhcVvFQSDmi/PAGvq0GVdzDff2uqEvt0zuxKs1QH5aTHn5GtOaUSyIQNUvl9Ok1YA5LfdX0v/908w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780170355; c=relaxed/simple;
	bh=nYlM2G8ceGl3y9T5fnmZhdbw8OoHi6DfQitXHZGs+Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u7ZJ05oBeckzeXlZnq+ysLS8Sk1XqAV9gVmUboFUqVR/kE/uDl+A8HTtp/GyxwZFxraW10yP8VR6+O3T25Ll6VLvVNiWaGDRjqoaQpk4fkqWG48yGjF6wBnaYcTXyQKA13A1cu4lrsJXOCuRcBBIBJ70JhhCf/u4BJsS3DHm4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/6dimAW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490a7a34493so427725e9.0
        for <linux-scsi@vger.kernel.org>; Sat, 30 May 2026 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780170352; x=1780775152; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sp2k/2dsuU3p5cNxUvdrCd2ECXlssNRbjfeNkqPWDi0=;
        b=p/6dimAWFhxgAFQz8VMJid+2/ubVOs/09iXD6eanc2QUidoqI6a5oEuV/wZBJDGAZt
         DKo0iAPNbqW3x5Mlsmmi0ToI1icHv/7QZSagdxndY27kuNuLUf5bD5DqKC2H2CIWxWLI
         gkC2UuaGVlUi70nGUK4cgwelwahpqIuAfJ043bIukQ5C3bO6+yJyVJSybbMD/yPkHgyD
         sY4c4ZNE/LA3uR4ghM2rgQVF6QMAY8pAtZD11zNSeOR0e/5zfbOXZ3MIWrD4ruVtlPnv
         SRkml10O5eOSOBXknup0ybPH1rpcCVG69RHM4yJwGsd7y2IUZFF9hcye1gQgLrK8pjlA
         pG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780170352; x=1780775152;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sp2k/2dsuU3p5cNxUvdrCd2ECXlssNRbjfeNkqPWDi0=;
        b=XTBEZJVhVT48w14nhWYHwPX2Fqn5qJHHjq2aKzIvwxJqEGBlf3VnCghS8wG09u9YNB
         deY3gGZ/WnERjX8DwYyonl7X+ApRni/FkAJ2QGuHABVY2jgFaU1N/bcH/JCEyd6KIeJT
         LYobwUXXreefUh8CiXfmE2Q0FV2gdp1RokS/VyqRbi81b0yMSt5GSW3zHfY9TuMAS2of
         0EVpDKWYOkYMqDyrLLBOV0BId023lniAG12Gxyei6kRnTXfezpqX2ox7kHDOaNefDGRG
         2uYHC58WtQYYEotj827Sxklp5BxuvxtYAkWwQbVsbuok5lnkOZ36bxA20kdZpGqbwEXb
         4/Bw==
X-Forwarded-Encrypted: i=1; AFNElJ+b+S3/KF9GZLogGheljQQOoamCbj3pUChIaEp9u6hs/9vDVQceAZ9hZVFZVydzgMIbcBk8TUa/ApCm@vger.kernel.org
X-Gm-Message-State: AOJu0YwZdMOb2d1ei8bMyPPSZ1klbuWPTKtzkkV/e29aO5gyW0t4l7n/
	NfvyNt5AU9C+KYAX0W/Do2O8WprSK0cujd59YqAn59kg+hvFFPoXynyr
X-Gm-Gg: Acq92OFToilBcvuIN1yatFb/ozYISgGtd6MDj/fQuksvhQVpryS8QeqolQJajMioovs
	P8fzUKfDK+ZGuB86DhIF0tA7dc00vBRQRqVJFB+PBlOZRwT8ozgOt+jEy+7lrNnpcPMFAiAg71r
	f6JqVyeWjZgN8d5VbpOvtneqHVupmWy3cek1Rt/HloABL+YeLyq5I+fRYQUMn4I0Q9RQ5ctbNkL
	1rCfJYrreKdwLXZZqugEQCxaNIFUAOqBc7NkYs0ApIDL1RHcmzoDDcK1jKlcPNaHHyesiRJsbGW
	UF0tUT6njZyRRT8II5/kXzRuUWtQHsFssa8t94tCJtzJxEkcy4LJv9yFMQ73lyr0Kg0SnV0o5Rd
	FXhpBf3LK65SCwOCvGK1arxWpTJUW1PvUEoyK63dxISBqSr/x/GjL16COA0T47iXt+6z8reYMoI
	R8V6HnWHm2cLm6IPTsLDPIfJkUoUP/+xGXmp428Zjb0S1v
X-Received: by 2002:a05:600c:314e:b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-490a2a78973mr64877725e9.15.1780170352446;
        Sat, 30 May 2026 12:45:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909caa7eeesm126175175e9.10.2026.05.30.12.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 12:45:51 -0700 (PDT)
Date: Sat, 30 May 2026 22:45:48 +0300
From: Dan Carpenter <error27@gmail.com>
To: Deepak Ukey <deepak.ukey@microchip.com>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Radha Ramachandran <radha@google.com>,
	Viswas G <Viswas.G@microchip.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] scsi: pm8001: Fix error code in non_fatal_log_show()
Message-ID: <ahs-bEsBJH0KhnsX@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24255-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3191161311E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The non_fatal_log_show() function is supposed to return negative
error codes on failure.  But because the error codes are saved in
a u32 and then cast to signed long, they end up being high positive
values instead of negative.  Remove the intermediary u32 variable
to fix this bug.

Fixes: dba2cc03b9db ("scsi: pm80xx: sysfs attribute for non fatal dump")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/scsi/pm8001/pm8001_ctl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index bb38b2d63acb..a27f3287748e 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -588,10 +588,7 @@ static DEVICE_ATTR(fatal_log, S_IRUGO, pm8001_ctl_fatal_log_show, NULL);
 static ssize_t non_fatal_log_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
-	u32 count;
-
-	count = pm80xx_get_non_fatal_dump(cdev, attr, buf);
-	return count;
+	return pm80xx_get_non_fatal_dump(cdev, attr, buf);
 }
 static DEVICE_ATTR_RO(non_fatal_log);
 
-- 
2.53.0


