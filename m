Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEEADA554
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Oct 2019 08:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404664AbfJQGMi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Oct 2019 02:12:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4235 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392531AbfJQGMi (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Oct 2019 02:12:38 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 02B1AC959CFABE33188C;
        Thu, 17 Oct 2019 14:12:37 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 14:12:27 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH v4 0/2] scsi: core: fix uninit-value access of variable sshdr
Date:   Thu, 17 Oct 2019 14:19:35 +0800
Message-ID: <1571293177-117087-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

v1->v2: modify the comments suggested by Bart
v2->v3: fix bug in sr_do_ioctl
v3->v4: let "fix bug in sr_do_ioctl" be a separate patch

zhengbin (2):
  sr: need to check whether sshdr is valid in sr_do_ioctl
  scsi: core: fix uninit-value access of variable sshdr

 drivers/scsi/scsi_lib.c | 7 +++++++
 drivers/scsi/sr_ioctl.c | 5 +++++
 2 files changed, 12 insertions(+)

--
2.7.4

