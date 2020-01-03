Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB812F753
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jan 2020 12:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgACLfD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 Jan 2020 06:35:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43576 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgACLfD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 3 Jan 2020 06:35:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id x6so22352388pfo.10
        for <linux-scsi@vger.kernel.org>; Fri, 03 Jan 2020 03:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LMe7z6ddgyf8t53yVaeLzGFz9Vaj78tpxLX8eoD6fg0=;
        b=BHakF1rI1o8leYM7NrdkD/qlRau1tu9KRE+UmFmnPmEfDzJz9hABep3jQQABJmHl70
         NfPsezxiM4OrSN3FfsXf52fSw9AQuX1DdF022ULYUy9bRRfeucPu+9N5QlpVzn/+GnJd
         prnmZ3QyPyrX3iebQW1uXFA1MsVyD67gLKdW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LMe7z6ddgyf8t53yVaeLzGFz9Vaj78tpxLX8eoD6fg0=;
        b=oQUPsx30V2U7AZml8HDTu908Kc8DNENta5KJKXTpUv3a852dYXyrTFESd5ceAeUhPX
         JFRyRPeyvsCh9OG7JvlI7zk/YfRuTW3mSVSTBIcBdWU1Aay/LcGuGbnx3TS/QWZQX6b7
         vvdDtny4eAJqoOEVEClhKhYWF/xXd6c+do6Z439OnwLsF1R05huXSPl0tIbKLp5aEXk8
         JRZB4t+oOIEqsl6r6obPWF9p9Y7kucgyWDFnm73sECw6y7PoheTlvznfmmU3hXxDKKpW
         GzltNkw6Raxr/lqn4GNd/espLlSqcpQvgfuPFq+2a7ASz/yuOZmdKhI6gsas/ji38SWn
         dGHg==
X-Gm-Message-State: APjAAAUcxU+d0llk1SqQPz3DqPy6Eg/BodqPbhYITz0n/njARCXFNz1j
        L+pwk+7/YVSzn7kEqFAaqywnX9rQtt1smhwPx+BrfmS56w3UHg1yRpXN0+tIU29CDhqLCFVOct7
        PvCur/ojADUAzy2ms3ZNMBPbb6kzo2zDOXMc4/ixiixAVxvz9diE8fmWaAK4i5gXyEij6IEg0ZU
        JrjcvBhw==
X-Google-Smtp-Source: APXvYqxJ6EBPX2Gp4PAERj85vJ0kw9syOtdCttZMd9DfGfT28q3DwhooUQUHwhh3GHJPGXzCfFOPjw==
X-Received: by 2002:a63:ff5c:: with SMTP id s28mr93934890pgk.196.1578051302493;
        Fri, 03 Jan 2020 03:35:02 -0800 (PST)
Received: from dhcp-10-123-20-32.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id h128sm70302144pfe.172.2020.01.03.03.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 03:35:02 -0800 (PST)
From:   Anand Lodnoor <anand.lodnoor@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com,
        Anand Lodnoor <anand.lodnoor@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH 05/11] megaraid_sas: Do not kill HBA if JBOD Seqence map or RAID map is disabled
Date:   Fri,  3 Jan 2020 17:02:29 +0530
Message-Id: <1578051155-14716-6-git-send-email-anand.lodnoor@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578051155-14716-1-git-send-email-anand.lodnoor@broadcom.com>
References: <1578051155-14716-1-git-send-email-anand.lodnoor@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Anand Lodnoor <anand.lodnoor@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index e301458..ef20234 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -1312,7 +1312,9 @@ static int megasas_create_sg_sense_fusion(struct megasas_instance *instance)
 	}
 
 	if (ret == DCMD_TIMEOUT)
-		megaraid_sas_kill_hba(instance);
+		dev_warn(&instance->pdev->dev,
+			 "%s DCMD timed out, continue without JBOD sequence map\n",
+			 __func__);
 
 	if (ret == DCMD_SUCCESS)
 		instance->pd_seq_map_id++;
@@ -1394,7 +1396,9 @@ static int megasas_create_sg_sense_fusion(struct megasas_instance *instance)
 		ret = megasas_issue_polled(instance, cmd);
 
 	if (ret == DCMD_TIMEOUT)
-		megaraid_sas_kill_hba(instance);
+		dev_warn(&instance->pdev->dev,
+			 "%s DCMD timed out, RAID map is disabled\n",
+			 __func__);
 
 	megasas_return_cmd(instance, cmd);
 
-- 
1.8.3.1

