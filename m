Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 719CF8066C
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 16:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391008AbfHCOAN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 10:00:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37405 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbfHCOAM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 10:00:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so4655064pgp.4
        for <linux-scsi@vger.kernel.org>; Sat, 03 Aug 2019 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=efLwhG0YC+uhlzEO2fzT58whGcj2lqMnTbkUHu4S1wg=;
        b=heCCxK6SWEg/1+rjQQuiqVNp+VxOWtvWU6FC2o+md2+OcS9/O1DH/LUm3VUGUClk1W
         6DxeQRzVUEZAwSfPorGSHwTWh9BWVdG0EXzIOma7+eIX51xSGooGPeX20SnhJm6ByUuv
         DS8KUjdmiQfjnJR/M+nSpQXgYyR+gSKBj5/Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=efLwhG0YC+uhlzEO2fzT58whGcj2lqMnTbkUHu4S1wg=;
        b=kVWdWZ0raqch3al33GcuiJgOyqSh8PP3wBS57dHBD2WztpDAOwfn/ywYjgH8lXIuzd
         iPjQBrrnxS+F/QIwbwh5J3rUIXr69EBHm7wM5gQeA7FkWgs4uaKdkexb0954MG/R9scz
         y+FJQtvFsz3wnI6TIonbYp82rZ8a8CL/sS/WpV34VDtCBmmv3gocOvLsdGAZwxmYD4Ni
         4NgOhjBmQBF6EojbBoEb3KjrhrGUIVL/n4KTjuNOsPxGWsMuyyFaNKDSA87+vilbp5j/
         TsLy0X36L9MMrf/YX2ZucyViSUZOPJ1E98zLo5GT41o8+pPglooEEmE7dfoeOgmTdNDm
         6wAw==
X-Gm-Message-State: APjAAAU2a26EP4+saggxRdiN6j9UV1Cd505mvmn0qCDDoQO/AkkGAbic
        DBAQQ6WrTG6MEd3eI0KGI5aRs4tjFh7rg0c1MdFPRelfoFkl4Q1vLEST5qOlMuO8er9ttKkejCZ
        wa4zXQ5GLBosW1cGW+qEElwGfVeumv6x6RlID+5E9nqYeolH0daSppfwSg+3QpkrtcCUD+mkQDD
        9ojqbiK63YwYpZzgZGXA==
X-Google-Smtp-Source: APXvYqxcGDrOJ8JqUl1wpTUx8RL3B26mrYeOrNYN9iHnPMMwRRiIeMqK9pOtp375RQ61d8q1hy6NxA==
X-Received: by 2002:a63:c50f:: with SMTP id f15mr29073101pgd.372.1564840811838;
        Sat, 03 Aug 2019 07:00:11 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c69sm11711615pje.6.2019.08.03.07.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:00:11 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 01/12] mpt3sas: Add support for PCIe Lane margin
Date:   Sat,  3 Aug 2019 09:59:46 -0400
Message-Id: <1564840797-5876-2-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

PCIe Lane margin tool box request requires IEEE sgl's and hence
driver fills the SGL field with IEEE sgl's while issuing the
PCIe Lane margin ioctl request to the HBA firmware.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index d4ecfbb..acd803a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -921,13 +921,14 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 		Mpi2ToolboxCleanRequest_t *toolbox_request =
 			(Mpi2ToolboxCleanRequest_t *)mpi_request;
 
-		if (toolbox_request->Tool == MPI2_TOOLBOX_DIAGNOSTIC_CLI_TOOL) {
+		if ((toolbox_request->Tool == MPI2_TOOLBOX_DIAGNOSTIC_CLI_TOOL)
+		    || (toolbox_request->Tool ==
+		    MPI26_TOOLBOX_BACKEND_PCIE_LANE_MARGIN))
 			ioc->build_sg(ioc, psge, data_out_dma, data_out_sz,
 				data_in_dma, data_in_sz);
-		} else {
+		else
 			ioc->build_sg_mpi(ioc, psge, data_out_dma, data_out_sz,
 				data_in_dma, data_in_sz);
-		}
 		ioc->put_smid_default(ioc, smid);
 		break;
 	}
-- 
1.8.3.1

