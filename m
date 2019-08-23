Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6CEA9B149
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Aug 2019 15:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393402AbfHWNtp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Aug 2019 09:49:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37040 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390369AbfHWNtp (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Aug 2019 09:49:45 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 10A042C5AB465F616EE0;
        Fri, 23 Aug 2019 21:49:41 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 23 Aug 2019
 21:49:32 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH 0/2] scsi: csiostor: remove some set but not used variables
Date:   Fri, 23 Aug 2019 21:56:02 +0800
Message-ID: <1566568564-55636-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

zhengbin (2):
  scsi: csiostor: remove set but not used variables
    'mc_bist_status_rdata_reg','edc_bist_status_rdata_reg'
  scsi: csiostor: remove set but not used variable 'rln'

 drivers/scsi/csiostor/csio_hw_t5.c | 6 ++----
 drivers/scsi/csiostor/csio_lnode.c | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

--
2.7.4

