Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76794232A6C
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Jul 2020 05:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgG3Dan (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Jul 2020 23:30:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726724AbgG3Dan (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 Jul 2020 23:30:43 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7895CBB3EB725CF83F12;
        Thu, 30 Jul 2020 11:30:41 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 11:30:35 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <MPT-FusionLinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 0/3] scsi: Remove superfluous memset()
Date:   Thu, 30 Jul 2020 11:31:55 +0800
Message-ID: <1596079918-41115-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

*** BLURB HERE ***

Li Heng (3):
  scsi: Remove superfluous memset()
  scsi: Remove superfluous memset()
  scsi: Remove superfluous memset()

 drivers/scsi/mpt3sas/mpt3sas_base.c | 1 -
 drivers/scsi/pmcraid.c              | 1 -
 drivers/scsi/qla2xxx/qla_mbx.c      | 2 --
 3 files changed, 4 deletions(-)

--
2.7.4

