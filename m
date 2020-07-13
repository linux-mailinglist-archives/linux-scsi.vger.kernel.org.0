Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F691219FFB
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jul 2020 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGIM1I (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Jul 2020 08:27:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726615AbgGIM1I (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 9 Jul 2020 08:27:08 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 65832114D74646D6D6F1;
        Thu,  9 Jul 2020 20:27:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 9 Jul 2020 20:26:58 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <hare@suse.com>,
        <dgilbert@interlog.com>, <ming.lei@redhat.com>,
        <kashyap.desai@broadcom.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/2] scsi: scsi_debug: Support hostwide tags and a fix
Date:   Thu, 9 Jul 2020 20:23:18 +0800
Message-ID: <1594297400-24756-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This series includes hostwide tags support, so we can mimic some SCSI HBAs,
like megaraid sas or hisi_sas.

There is also a fix for an out-of-range module param.

Differences to v1:
- add Doug's Ack for patch 1/2
- sort params alphabetically
- fix max queue at host max queue (when non-zero)
- drop host max queue file write permission

John Garry (2):
  scsi: scsi_debug: Add check for sdebug_max_queue during module init
  scsi: scsi_debug: Support hostwide tags

 drivers/scsi/scsi_debug.c | 86 +++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 12 deletions(-)

-- 
2.26.2

