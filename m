Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6C3F5BA5
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Aug 2021 12:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbhHXKGi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 24 Aug 2021 06:06:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3681 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbhHXKGd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 24 Aug 2021 06:06:33 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gv4TX2c5Dz67byN;
        Tue, 24 Aug 2021 18:04:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 24 Aug 2021 12:05:47 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 24 Aug 2021 11:05:45 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/5] hisi_sas: Some misc patches for next
Date:   Tue, 24 Aug 2021 18:00:55 +0800
Message-ID: <1629799260-120116-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This series contains some minor misc patches, including:
- Fix debugfs dump index
- Stop printing #hw queues
- Use PCI managed functions
- Some timer changes

Thanks in advance!

John Garry (1):
  scsi: hisi_sas: Remove print in v3 hw probe about #hw queues

Luo Jiaxing (2):
  scsi: hisi_sas: Rename HISI_SAS_{RESET -> RESETTING}_BIT
  scsi: hisi_sas: Increase debugfs_dump_index after dump is completed

Xiang Chen (2):
  scsi: hisi_sas: Use managed PCI functions
  scsi: hisi_sas: Replace some del_timer() calls with del_timer_sync()

 drivers/scsi/hisi_sas/hisi_sas.h       |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 24 ++++++++---------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  8 +++---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 37 +++++++++++---------------
 5 files changed, 33 insertions(+), 40 deletions(-)

-- 
2.26.2

