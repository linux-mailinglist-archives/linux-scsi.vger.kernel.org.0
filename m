Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C652591C6
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Sep 2020 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgIAOzU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Sep 2020 10:55:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbgIALeb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 1 Sep 2020 07:34:31 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3993EC35029B59C9FEAA;
        Tue,  1 Sep 2020 19:17:07 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Sep 2020 19:16:58 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/8] hisi_sas: Misc patches
Date:   Tue, 1 Sep 2020 19:13:02 +0800
Message-ID: <1598958790-232272-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This series contains some minor feature updates and general tidying:
- Some new BIST features
- Stop modifying previously unused fields in programmable link rate reg
- Stop accessing some SSP task fields for SMP tasks
- General minor tidying

Thanks!

Luo Jiaxing (6):
  scsi: hisi_sas: Modify macro name for OOB phy linkrate
  scsi: hisi_sas: Do not modify upper fields of PROG_PHY_LINK_RATE reg
  scsi: hisi_sas: Make phy index variable name consistent
  scsi: hisi_sas: Add BIST support for phy FFE
  scsi: hisi_sas: Add BIST support for fixed code pattern
  scsi: hisi_sas: Some very minor tidying

Xiang Chen (2):
  scsi: hisi_sas: Avoid accessing to SSP task for SMP IOs
  scsi: hisi_sas: Add carriage returns to some prints

 drivers/scsi/hisi_sas/hisi_sas.h       |  35 ++++++
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 113 +++++++++++++++----
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  24 ++--
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   4 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 146 +++++++++++++++----------
 5 files changed, 229 insertions(+), 93 deletions(-)

-- 
2.26.2

