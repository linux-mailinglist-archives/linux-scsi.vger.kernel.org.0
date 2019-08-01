Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925DA7E197
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbfHAR4w (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43384 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR4w (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so34508097pfg.10
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlZPHnROSQmEhqyoGQC3KniX5oYJkC7VDtTe1ttaCCE=;
        b=OOIoLIXUErE5faNLOuTo5S4HRxLp6NP0pmi/YsxdgXtxEANrQrwaeABOPg4AsSFdUF
         Le3a0DuFhlKMvi40w5FgDmPiCzGJauOlRlGaiUV2/rgeWS+W0OwAoBmem5cxYjp73NL7
         +PE3YTzoN11oelgdPQuz7aaK9mm6seKh8gkNH6VrSBKUVKkKHdo5iDVTlCShkm8/SAC9
         /fexm4iRn32D+1P7Wc1jd5lsWLT488XeCsGvx/n9vLjdkPLOPzRCf7cySYcITRy6bdE3
         J6xgtJBvzMFwsCAjtcef30Ta8sxax83Wqat3zJHVhu39mUmCGOIFiKbcgNK9v4oy3q9B
         MFEQ==
X-Gm-Message-State: APjAAAUVG65wsB9iOFucJwzdqpO5ODTt8NU8NG1qW8kKuf2WmVIT3JGb
        HHDhSiuKsl7ruQ6xSe5QaaI=
X-Google-Smtp-Source: APXvYqxARfhnbhGD9pUTGT2o0hkp0aR02hyuEEaBtJ4CrB5iB3eFys9X5xXYpZ+8CkooVZ+ePUwLZQ==
X-Received: by 2002:a62:1652:: with SMTP id 79mr54959636pfw.20.1564682211291;
        Thu, 01 Aug 2019 10:56:51 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:50 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 22/59] qla2xxx: Use strlcpy() instead of strncpy()
Date:   Thu,  1 Aug 2019 10:55:37 -0700
Message-Id: <20190801175614.73655-23-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch fixes several gcc complaints about string truncation.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_mr.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index cd892edec4dc..b6be7e7f2a43 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -1880,22 +1880,22 @@ qlafx00_fx_disc(scsi_qla_host_t *vha, fc_port_t *fcport, uint16_t fx_type)
 			phost_info = &preg_hsi->hsi;
 			memset(preg_hsi, 0, sizeof(struct register_host_info));
 			phost_info->os_type = OS_TYPE_LINUX;
-			strncpy(phost_info->sysname,
-			    p_sysid->sysname, SYSNAME_LENGTH);
-			strncpy(phost_info->nodename,
-			    p_sysid->nodename, NODENAME_LENGTH);
+			strlcpy(phost_info->sysname, p_sysid->sysname,
+				sizeof(phost_info->sysname));
+			strlcpy(phost_info->nodename, p_sysid->nodename,
+				sizeof(phost_info->nodename));
 			if (!strcmp(phost_info->nodename, "(none)"))
 				ha->mr.host_info_resend = true;
-			strncpy(phost_info->release,
-			    p_sysid->release, RELEASE_LENGTH);
-			strncpy(phost_info->version,
-			    p_sysid->version, VERSION_LENGTH);
-			strncpy(phost_info->machine,
-			    p_sysid->machine, MACHINE_LENGTH);
-			strncpy(phost_info->domainname,
-			    p_sysid->domainname, DOMNAME_LENGTH);
-			strncpy(phost_info->hostdriver,
-			    QLA2XXX_VERSION, VERSION_LENGTH);
+			strlcpy(phost_info->release, p_sysid->release,
+				sizeof(phost_info->release));
+			strlcpy(phost_info->version, p_sysid->version,
+				sizeof(phost_info->version));
+			strlcpy(phost_info->machine, p_sysid->machine,
+				sizeof(phost_info->machine));
+			strlcpy(phost_info->domainname, p_sysid->domainname,
+				sizeof(phost_info->domainname));
+			strlcpy(phost_info->hostdriver, QLA2XXX_VERSION,
+				sizeof(phost_info->hostdriver));
 			preg_hsi->utc = (uint64_t)ktime_get_real_seconds();
 			ql_dbg(ql_dbg_init, vha, 0x0149,
 			    "ISP%04X: Host registration with firmware\n",
-- 
2.22.0.770.g0f2c4a37fd-goog

