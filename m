Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2FD4EF339
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Apr 2022 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348882AbiDAO5c (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Apr 2022 10:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349279AbiDAOpn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 Apr 2022 10:45:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D439D29A55D;
        Fri,  1 Apr 2022 07:35:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F11D60B9A;
        Fri,  1 Apr 2022 14:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC87C34112;
        Fri,  1 Apr 2022 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648823706;
        bh=Rbs7DnAUFvAXbZTT5xlzrTp8sk6yUOBZFc755WKAgkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DN9cvSxCAO+iR7b+OAbTV1xCXGkYicYiKc+pNAoWdf9VMTmr5h+AUg+6gthaXr5U1
         UxKDa17xPX1OqNDmY400yxvNE65bMLfZGU488iWxe1HBoIDxQuafwV/ZjhXWe+qXFd
         vkhCX1xzRJbqcPkkHDxc/yDh20OnsVdbVL+oYaUldFaLWw+RmIMgrR4Lz3mf0uqiR4
         E34hWKLLDonFz8V2RxirgLR0h7zCo6zJE9q1ZaGFlJLyCH992y5XYxYbUaWrHS6cMH
         CbEBeArHDzRciDGsXwuCqW+HPF6Ysi/UmD8YHOo/H4tmr3Rw5OykKB9hmjc916hME6
         mdyXGQzP/Q5yA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, sathya.prakash@broadcom.com,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        jejb@linux.ibm.com, mpi3mr-linuxdrv.pdl@broadcom.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 046/109] scsi: mpi3mr: Fix reporting of actual data transfer size
Date:   Fri,  1 Apr 2022 10:31:53 -0400
Message-Id: <20220401143256.1950537-46-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401143256.1950537-1-sashal@kernel.org>
References: <20220401143256.1950537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>

[ Upstream commit 9992246127246a27cc7184f05cce6f62ac48f84e ]

The driver is missing to set the residual size while completing an
I/O. Ensure proper data transfer size is reported to the kernel on I/O
completion based on the transfer length reported by the firmware.

Link: https://lore.kernel.org/r/20220210095817.22828-7-sreekanth.reddy@broadcom.com
Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpi3mr/mpi3mr_os.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index fe10f257b5a4..224a4155d9b4 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -2204,6 +2204,8 @@ void mpi3mr_process_op_reply_desc(struct mpi3mr_ioc *mrioc,
 		scmd->result = DID_OK << 16;
 		goto out_success;
 	}
+
+	scsi_set_resid(scmd, scsi_bufflen(scmd) - xfer_count);
 	if (ioc_status == MPI3_IOCSTATUS_SCSI_DATA_UNDERRUN &&
 	    xfer_count == 0 && (scsi_status == MPI3_SCSI_STATUS_BUSY ||
 	    scsi_status == MPI3_SCSI_STATUS_RESERVATION_CONFLICT ||
-- 
2.34.1

