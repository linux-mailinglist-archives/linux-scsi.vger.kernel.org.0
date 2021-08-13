Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852483EB64B
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Aug 2021 15:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbhHMNye (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 Aug 2021 09:54:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3646 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbhHMNyd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 13 Aug 2021 09:54:33 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GmQ4f4PD8z6GC2N;
        Fri, 13 Aug 2021 21:53:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 13 Aug 2021 15:54:04 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 13 Aug 2021 14:54:00 +0100
From:   John Garry <john.garry@huawei.com>
To:     <satishkh@cisco.com>, <sebaddel@cisco.com>, <kartilak@cisco.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.de>, <hch@lst.de>, <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/3] Remove scsi_cmnd.tag
Date:   Fri, 13 Aug 2021 21:49:10 +0800
Message-ID: <1628862553-179450-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There is no need for scsi_cmnd.tag, so remove it.

Based on next-20210811

John Garry (3):
  scsi: wd719: Stop using scsi_cmnd.tag
  scsi: fnic: Stop setting scsi_cmnd.tag
  scsi: Remove scsi_cmnd.tag

 drivers/scsi/fnic/fnic_scsi.c | 2 +-
 drivers/scsi/scsi_lib.c       | 1 -
 drivers/scsi/wd719x.c         | 8 +++++---
 include/scsi/scsi_cmnd.h      | 1 -
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.26.2

