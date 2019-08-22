Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 879E299556
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Aug 2019 15:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389215AbfHVNlp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Aug 2019 09:41:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48544 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732725AbfHVNlp (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 22 Aug 2019 09:41:45 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C1BBEB227FE237B55432;
        Thu, 22 Aug 2019 21:41:39 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 21:41:30 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <QLogic-Storage-Upstream@qlogic.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH 0/3] scsi: qla4xxx: remove some set but not used variables
Date:   Thu, 22 Aug 2019 21:47:58 +0800
Message-ID: <1566481681-92765-1-git-send-email-zhengbin13@huawei.com>
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
  scsi: qla4xxx: remove set but not used variables
    'data_size','poll','mask'
  scsi: qla4xxx: remove set but not used variable 'func_number'
  scsi: qla4xxx: remove set but not used variables
    'sess','dst_addr','db_base','db_len','ha'

 drivers/scsi/qla4xxx/ql4_init.c |  2 --
 drivers/scsi/qla4xxx/ql4_nx.c   |  9 +++------
 drivers/scsi/qla4xxx/ql4_os.c   | 11 +----------
 3 files changed, 4 insertions(+), 18 deletions(-)

--
2.7.4

