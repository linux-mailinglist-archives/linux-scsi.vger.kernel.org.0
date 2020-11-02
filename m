Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2502A2CD4
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Nov 2020 15:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgKBOZz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Nov 2020 09:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgKBOYJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 Nov 2020 09:24:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69A8C061A04
        for <linux-scsi@vger.kernel.org>; Mon,  2 Nov 2020 06:24:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g12so14800292wrp.10
        for <linux-scsi@vger.kernel.org>; Mon, 02 Nov 2020 06:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRHYymPZSeiW3b0Obvxms+pRftWjvOHGSla0h5dK+wA=;
        b=Z8GK6Wrr4KYFOS16qlmFYs17AR15SvoZhng3PEGCzaFVX1DAJnQT55BeY4ITYbJNoI
         Gy2WOPBi07WQ8v+wNMMswjKN5PqNLvcT4FJ6TY/VNFBZX/luNfdfEr8hXFyoOyZTJ0S/
         Mt76KDJnig3XhUGlajZ7UdOJps9tqZubVPufx/eXBWixw99a9OdTQrsKoYChpduaujqc
         uQQ2ikNF9umG2iRDOPa2HXydTckZdX/VPdXUhQ7eM8pHFI4bnZJazRTErbHqmoXqvIPV
         sUsKks2Ga87ktBR52sPwcKWyya7T8fq34dYcUarg7FEBvJB8Iq7gpOrQqUmhwB5RrVeP
         hlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRHYymPZSeiW3b0Obvxms+pRftWjvOHGSla0h5dK+wA=;
        b=d/f5APS4weXdASnlQwYpawlg5fNAE66ik9twYw+z6V+PCpMCAYh2BSTIjOfrTWQKHx
         PKWBlXAfG3hFlf8DvRMRWDStyhKEmZJHJBCYJ12b7uFy8FT7QvHwMt2N3j3p1CaT/HP6
         OSPNvfCo8KQumF+6m4lelVW6RqgqGAYK7jM1nf26z1diqi3n+yHWN4UG4YPBTnZoecB2
         Q7BdPFeqCv4kfBZHV6pKhgv2MkkAiCzGgcDom7kzwTz8XrxmWYkzlxcUCpNFPsZpRut+
         AzlWvT9tnVKhDr3ZiM9wnn3OpPEhAA6PZPPGB0l6s12+FXRc7GtkDlsi7/4peL0vD5wc
         UmAw==
X-Gm-Message-State: AOAM530bVz4gzH4Ty+GdMIWhT7PG0Va2JIEBhhvE9Udkk6flnteNAUhD
        /jcoSYMXhNZi73Qktemb+Kz7HQ==
X-Google-Smtp-Source: ABdhPJycEZEUIHnRaz29PDCXGWx2dsNsCuGiwlKFE4TpZy11ZnlgehGv5JqMdeTJi4rmj+GA1NUVpg==
X-Received: by 2002:adf:e64e:: with SMTP id b14mr20521345wrn.68.1604327046663;
        Mon, 02 Nov 2020 06:24:06 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f7sm23542501wrx.64.2020.11.02.06.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:24:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@avagotech.com, MPT-FusionLinux.pdl@broadcom.com
Subject: [RESEND 02/19] scsi: mpt3sas: mpt3sas_scsih: Fix function documentation formatting
Date:   Mon,  2 Nov 2020 14:23:42 +0000
Message-Id: <20201102142359.561122-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102142359.561122-1-lee.jones@linaro.org>
References: <20201102142359.561122-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/mpt3sas/mpt3sas_scsih.c:2778: warning: Function parameter or member 'ioc' not described in 'scsih_tm_cmd_map_status'
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:2778: warning: Function parameter or member 'channel' not described in 'scsih_tm_cmd_map_status'
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:2829: warning: Function parameter or member 'ioc' not described in 'scsih_tm_post_processing'
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:2829: warning: Function parameter or member 'channel' not described in 'scsih_tm_post_processing'

Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: MPT-FusionLinux.pdl@avagotech.com
Cc: MPT-FusionLinux.pdl@broadcom.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 5f845d7094fcc..f01983dc73703 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2762,8 +2762,8 @@ mpt3sas_scsih_clear_tm_flag(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 
 /**
  * scsih_tm_cmd_map_status - map the target reset & LUN reset TM status
- * @ioc - per adapter object
- * @channel - the channel assigned by the OS
+ * @ioc: per adapter object
+ * @channel: the channel assigned by the OS
  * @id: the id assigned by the OS
  * @lun: lun number
  * @type: MPI2_SCSITASKMGMT_TASKTYPE__XXX (defined in mpi2_init.h)
@@ -2808,9 +2808,9 @@ scsih_tm_cmd_map_status(struct MPT3SAS_ADAPTER *ioc, uint channel,
 
 /**
  * scsih_tm_post_processing - post processing of target & LUN reset
- * @ioc - per adapter object
+ * @ioc: per adapter object
  * @handle: device handle
- * @channel - the channel assigned by the OS
+ * @channel: the channel assigned by the OS
  * @id: the id assigned by the OS
  * @lun: lun number
  * @type: MPI2_SCSITASKMGMT_TASKTYPE__XXX (defined in mpi2_init.h)
-- 
2.25.1

