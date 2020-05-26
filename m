Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD031BBB16
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Apr 2020 12:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgD1KUT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 Apr 2020 06:20:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38808 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgD1KUR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 Apr 2020 06:20:17 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jTNLa-0002bp-1H; Tue, 28 Apr 2020 10:20:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Arun Easi <aeasi@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: qla2xxx: make 1 bit bit-fields unsigned int
Date:   Tue, 28 Apr 2020 11:20:13 +0100
Message-Id: <20200428102013.1040598-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The bitfields mpi_fw_dump_reading and mpi_fw_dumped are currently signed
which is not recommended as the representation is an implementation defined
behaviour.  Fix this by making the bit-fields unsigned ints.

Fixes: cbb01c2f2f63 ("scsi: qla2xxx: Fix MPI failure AEN (8200) handling")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/qla2xxx/qla_def.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index daa9e936887b..172ea4e5887d 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4248,8 +4248,8 @@ struct qla_hw_data {
 	int		fw_dump_reading;
 	void		*mpi_fw_dump;
 	u32		mpi_fw_dump_len;
-	int		mpi_fw_dump_reading:1;
-	int		mpi_fw_dumped:1;
+	unsigned int	mpi_fw_dump_reading:1;
+	unsigned int	mpi_fw_dumped:1;
 	int		prev_minidump_failed;
 	dma_addr_t	eft_dma;
 	void		*eft;
-- 
2.25.1

