Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D9E80672
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 16:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391068AbfHCOA1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 10:00:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43840 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391048AbfHCOA1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 10:00:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so27724564pld.10
        for <linux-scsi@vger.kernel.org>; Sat, 03 Aug 2019 07:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DhdDwRTZnIL6mfxKCAscOtjJxfR6DI0aEr2pNtYrLy8=;
        b=QF12wNNhhRGdJa8mOe/neuLdSBWpJ5UKKsUlMoUwcp0gENPtSNRJ33Vg5ZJi50oPjh
         ZD8TNXV5YEo8GOvzfLuYuiR7eBFkkH6dwn4S66kjjLFHXWstgClSM7y0Zu4HUSg4cycQ
         AIxfg4RWSNGWdJ7w4hQgZ8lEDXRKcimJ0gQVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DhdDwRTZnIL6mfxKCAscOtjJxfR6DI0aEr2pNtYrLy8=;
        b=d2r69nMdjHV3sH+OPBlkC1VUx6JcHLgCaisl1k4ir9f0cQbywYLfmdF4/aNu3pof9E
         wkJK4zA6yDv4Uq8RKuHQbyGj2V+EdvdhSLRZ2FoDD/blNYCTINzwFk6JiNFX7kM2WhG1
         EPKB8rJ26LfUYASTN8ZpNHjzSU+8qqzM8tFFHa/hC55qfixm6J9y0LztepfJrVIENPv4
         e0bOct4NLgJiQ7LVO4xypP6RWElqF13OJC24yQvAbWYiHhQkZowSzPJiadkUBngP6g4N
         PMicay2JYYmBH9UY/KvtPyxflINyEK9goL6qBFZZTD6vr60qz0P+TFJrkzK7Z8n8e9+g
         Zaiw==
X-Gm-Message-State: APjAAAVE/M0xT7EGbH9aK9hJPDrlnsOxYi9vlo1hFnxj2j0G1eK+Aiam
        AheBpiC2V/tceyRKpCfZNwch+3C1lBTiuJ02vC+Ca3FJCHRMon/PdmduWxDm+v1Hg4DAOHt/Iig
        /+f9SUZHQLEv66JW2KEPXs5fp0F7SKwg0IMZ9TJnsZkzmD2EkdQKLK7VcVeTpooK1RBwKyijJou
        cACDHBMAaWVE5EzzPs3Q==
X-Google-Smtp-Source: APXvYqweNBNyn1xl3amtLRbUhdmrzWQ7HZN0YbKuWJnP08UhASG0TE54mYj6VP5eo1KOHNJLGdGzLw==
X-Received: by 2002:a17:902:9a84:: with SMTP id w4mr16387064plp.160.1564840826554;
        Sat, 03 Aug 2019 07:00:26 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c69sm11711615pje.6.2019.08.03.07.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:00:25 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 07/12] mpt3sas: Support MEMORY MOVE Tool box command
Date:   Sat,  3 Aug 2019 09:59:52 -0400
Message-Id: <1564840797-5876-8-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Host uses the Memory Move Tool to copy data from any
source/destination combination of system memory and
IOC memory.

Memory Move Tool box request contains two SGE fields,
First SGE field must contains the source buffer details
described by an MPI Simple SGE.
The second SGE field must contains the destination buffer
details described by an MPI Simple SGE.

 Source   ->   Destination

1. IOC    ->   IOC    (Both the SGE's will be filled by application)

2. HOST   ->   HOST   (Both the SGE's will be filled by the host,
               application should give sgl_offset to first SGE offset)

3. IOC    ->   HOST   (Application will fill the first SGE and set the
               sgl_offset to second SGE and hence driver fills
               the second SGE)
4. HOST   ->   IOC    (Application will fill IOC buffer information in the
               first SGE and set the sgl_offset to second SGE.
               Then driver will fill the second SGE with Host buffer
               information and just before posting the command to the
               firmware, driver will swap these two SGEs so that first
               SGE contains the HOST buffer information and second SGE
               contains the IOC information.

Driver has to take care only the 4th case, other three cases are by default
supported by the current driver design.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 29ecaa4..7179e5f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -926,9 +926,32 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 				MPI26_TOOLBOX_BACKEND_PCIE_LANE_MARGIN))
 			ioc->build_sg(ioc, psge, data_out_dma, data_out_sz,
 				data_in_dma, data_in_sz);
-		else
+		else if (toolbox_request->Tool ==
+				MPI2_TOOLBOX_MEMORY_MOVE_TOOL) {
+			Mpi2ToolboxMemMoveRequest_t *mem_move_request =
+					(Mpi2ToolboxMemMoveRequest_t *)request;
+			Mpi2SGESimple64_t tmp, *src = NULL, *dst = NULL;
+
+			ioc->build_sg_mpi(ioc, psge, data_out_dma,
+					data_out_sz, data_in_dma, data_in_sz);
+			if (data_out_sz && !data_in_sz) {
+				dst =
+				    (Mpi2SGESimple64_t *)&mem_move_request->SGL;
+				src = (void *)dst + ioc->sge_size;
+
+				memcpy(&tmp, src, ioc->sge_size);
+				memcpy(src, dst, ioc->sge_size);
+				memcpy(dst, &tmp, ioc->sge_size);
+			}
+			if (ioc->logging_level & MPT_DEBUG_TM) {
+				ioc_info(ioc,
+				  "Mpi2ToolboxMemMoveRequest_t request msg\n");
+				_debug_dump_mf(mem_move_request,
+							ioc->request_sz/4);
+			}
+		} else
 			ioc->build_sg_mpi(ioc, psge, data_out_dma, data_out_sz,
-				data_in_dma, data_in_sz);
+			    data_in_dma, data_in_sz);
 		ioc->put_smid_default(ioc, smid);
 		break;
 	}
-- 
1.8.3.1

