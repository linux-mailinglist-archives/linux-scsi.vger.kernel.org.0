Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19AA49B093
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Aug 2019 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbfHWNQ7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Aug 2019 09:16:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4773 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731783AbfHWNQ7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Aug 2019 09:16:59 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B1D68771E414CBB0C2E4;
        Fri, 23 Aug 2019 21:16:28 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 23 Aug 2019
 21:16:22 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <QLogic-Storage-Upstream@qlogic.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH 0/3] scsi: bnx2fc: remove some set but not used variables
Date:   Fri, 23 Aug 2019 21:22:50 +0800
Message-ID: <1566566573-49300-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

zhengbin (3):
  scsi: bnx2fc: remove set but not used variable 'fh'
  scsi: bnx2fc: remove set but not used variables 'lport','host'
  scsi: bnx2fc: remove set but not used variables
    'task','port','orig_task'

 drivers/scsi/bnx2fc/bnx2fc_fcoe.c |  2 --
 drivers/scsi/bnx2fc/bnx2fc_hwi.c  | 16 ----------------
 drivers/scsi/bnx2fc/bnx2fc_io.c   |  7 -------
 3 files changed, 25 deletions(-)

--
2.7.4

