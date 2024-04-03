Return-Path: <linux-scsi+bounces-3965-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3130C89620C
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Apr 2024 03:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F291F22F79
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Apr 2024 01:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C206134B2;
	Wed,  3 Apr 2024 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6CraYxp"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C09AD29B;
	Wed,  3 Apr 2024 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108161; cv=none; b=cn1dmgzYHNS1k5Yhg+g2Inkd+p6AjkEikFzC56wu4Q8d5SMce2va2JIGnUiQ3xqdZVT9z0tzHFoJr7fhOSVrawaVpt+GWieD4McfGIahZQ5g8Tkueodlv57pSYDd+JX215LXkz3w2v4miIrH8io5xAkTfxD9TJEv9ISMnKRneWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108161; c=relaxed/simple;
	bh=gpiz8ytPP4xNPIcRFhDKhFYNxujxRb4J0v0+KGwLOhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e9HRStJQRNlPGiEvSH6EUXHYOCLd53VHchpm8LB5wzmpMClRUJqzfG8BQs6TyB1Y8aTUMUaZ1ZHP+6avOLSQhXrx98tMtIbiERUylTW/pQm22ly9LQNN8fR/4iOfRGRXVNy2kBejdS1pogQfPbxOECl1SRAFjn8WP+VGcCSWtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6CraYxp; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1e2232e30f4so44448155ad.2;
        Tue, 02 Apr 2024 18:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712108159; x=1712712959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QgF+noOD10kOlj0U+9VFK/2VpTAYYndo6kiRXQ7BdA4=;
        b=j6CraYxp/e4BegwawSerYI3Cv3TiB8+DoNG/K80Kp+RJHUXvvF2z9oqEmAM+k+D9TT
         MOKF/GZAT2gTw+j50iSEdLXD8Jx3ArDfYYnbPSg4fdUY2cLIIyOc13Lefs6vZajRZSN9
         dfWySCb3ySlAAJVY6C5UlEg2422YzmD0BGTebXvmz9ChM2EGnmdeDHwRlrqkvegjXfFP
         HT1mTkI71lnXZnDOZOtw8tByZxsS3C96/Qa/eq9Q+GMOlaKGnUH1UV7CBYUOxzj2cvUE
         ABvzUUU0QWRAXmdSVidhwJgKhBJj1WbqkgyLZsS7FCzDHSyK78Bt0rdn9MZxUAzlWrdj
         cetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712108159; x=1712712959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgF+noOD10kOlj0U+9VFK/2VpTAYYndo6kiRXQ7BdA4=;
        b=Z0C7jeJ/vkIyR3crgDOZzESLX/rPxTo6VRlyTN2X/O7m62lyLgwJSJW/JyTSDsm8b2
         XzQCmZg677YHnAABTBFNNZ11Gt9QoK6xDffGc0CyF7WHz9ow3PCI4zkD9qU8DnkDgQl0
         +0Hk5WJgI7xR5S1eVi0wVk9OzIeaWdyFgs0WaEgS3J/nba4dfU1fSUcpv6w93Hhk2Hc/
         KPW1JnwfoP8uwr9cdZ9yy8Y7Pz7GHtgWuQI9rT5gqUoL2RLhWUMLwCxgRGlxcKksF+xQ
         NbCGuXph3vNHz3hnMliyFtiI+QarumJkITUVbv5q2iX3U0vniW7EXw8S3ukpoYLmCTLq
         bUYw==
X-Forwarded-Encrypted: i=1; AJvYcCXmXnWms+5g4Y0ODFh8wVc8y+yFI7mplM2HAb1YtCmHpJeqp9pfVrJ4n7Ew9+L2ixIGv/atCnxpsAVJ36JvW7qSQ+eAc7D+J4DvjWZf
X-Gm-Message-State: AOJu0YzCIxbg7CWn8xeaMi9YyOZHrRNjRzURrY42OS3ElaiG6/L4Pcd6
	+pQQfdZTypTQVoMHetwM0baKOJLKpyFVGQoghH1FEf/6ctCur/ka
X-Google-Smtp-Source: AGHT+IFQJNOcOrgUJgifMInR7KJAJpASys1be4mIJFPy4W5a9ldUl4XHTdPheBrRx4w/NzjZ0MoCgg==
X-Received: by 2002:a17:902:db11:b0:1e0:a1c7:571c with SMTP id m17-20020a170902db1100b001e0a1c7571cmr14722724plx.26.1712108159299;
        Tue, 02 Apr 2024 18:35:59 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id u14-20020a170903124e00b001e0e5722788sm11895692plh.17.2024.04.02.18.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 18:35:58 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: 
Date: Wed,  3 Apr 2024 09:35:51 +0800
Message-Id: <20240403013551.968852-1-qq810974084@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: [PATCH] scsi: lpfc: Fix a possible null pointer dereference

In function lpfc_xcvr_data_show, the memory allocation with kmalloc might
fail, thereby making rdp_context a null pointer. In the following context 
and functions that use this pointer, there are dereferencing operations,
leading to null pointer dereference.

To fix this issue, a null pointer check should be added. If it is null, 
write error message and jump to 'out_free_rdp'.

Fixes: 479b0917e447 ("scsi: lpfc: Create a sysfs entry called lpfc_xcvr_data for transceiver info")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index b1c9107d3408..b11e5114b7f2 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -1904,6 +1904,11 @@ lpfc_xcvr_data_show(struct device *dev, struct device_attribute *attr,
 
 	/* Get transceiver information */
 	rdp_context = kmalloc(sizeof(*rdp_context), GFP_KERNEL);
+	if (!rdp_context) {
+		len = scnprintf(buf, PAGE_SIZE - len,
+				"ERROR: Not enough memory\n");
+		goto out_free_rdp;
+	}
 
 	rc = lpfc_get_sfp_info_wait(phba, rdp_context);
 	if (rc) {
-- 
2.34.1


