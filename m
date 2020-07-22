Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D6722946F
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Jul 2020 11:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbgGVJGD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Jul 2020 05:06:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51980 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728642AbgGVJGC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 22 Jul 2020 05:06:02 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D540A48C73173991CFE3;
        Wed, 22 Jul 2020 17:05:59 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Jul 2020
 17:05:51 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <yanaijie@huawei.com>,
        <chenxiang66@hisilicon.com>, <luojiaxing@huawei.com>,
        <linuxarm@huawei.com>
Subject: [PATCH v1 0/2] scsi: libsas: An improvement on error handle and tidy-up
Date:   Wed, 22 Jul 2020 17:04:01 +0800
Message-ID: <1595408643-63011-1-git-send-email-luojiaxing@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch introduces an improvement to reduce error handle time and a
tidy-up, including: 
- postreset() is deleted from sas_sata_ops. 
- Do not perform hard reset and delayed retry on a removed SATA disk. This
can effectively reduce the error handle duration of hot unplug a SATA disk
with traffic(reduce about 30s depending on the delay setting of libata). 

Both John garry and Jason Yan participated in the review of the solution
and provided good suggestions during the development. 

Luo Jiaxing (2):
  {topost} scsi: libsas: delete postreset at sas_sata_ops
  {topost} scsi: libsas: check link status at ATA prereset() ops

 drivers/scsi/libsas/sas_ata.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.7.4

