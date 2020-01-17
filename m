Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDF9140952
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Jan 2020 12:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgAQL4l (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 Jan 2020 06:56:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:36732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgAQL4l (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 17 Jan 2020 06:56:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A323DBAB6;
        Fri, 17 Jan 2020 11:56:39 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Michael Reed <mdr@sgi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla1280: Make checking for 64bit support consistent
Date:   Fri, 17 Jan 2020 12:56:27 +0100
Message-Id: <20200117115628.13219-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use #ifdef QLA_64BIT_PTR to check if 64bit support is enabled.
This fixes ("scsi: qla1280: Fix dma firmware download, if dma
address is 64bit").

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/scsi/qla1280.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 607cbddcdd14..3337cd341d21 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -1699,7 +1699,7 @@ qla1280_load_firmware_pio(struct scsi_qla_host *ha)
 	return err;
 }
 
-#if QLA_64BIT_PTR
+#ifdef QLA_64BIT_PTR
 #define LOAD_CMD	MBC_LOAD_RAM_A64_ROM
 #define DUMP_CMD	MBC_DUMP_RAM_A64_ROM
 #define CMD_ARGS	(BIT_7 | BIT_6 | BIT_4 | BIT_3 | BIT_2 | BIT_1 | BIT_0)
-- 
2.24.1

