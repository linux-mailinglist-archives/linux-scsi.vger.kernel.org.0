Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65306216DD7
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2020 15:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgGGNg3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 Jul 2020 09:36:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728189AbgGGNg3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 7 Jul 2020 09:36:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E457D17FCAC270F38DB4;
        Tue,  7 Jul 2020 21:36:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Jul 2020 21:36:16 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <hare@suse.com>,
        <dgilbert@interlog.com>, <ming.lei@redhat.com>,
        <kashyap.desai@broadcom.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] scsi: scsi_debug: Support hostwide tags and a fix
Date:   Tue, 7 Jul 2020 21:32:29 +0800
Message-ID: <1594128751-212234-1-git-send-email-john.garry@huawei.com>
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

John Garry (2):
  scsi: scsi_debug: Add check for sdebug_max_queue during module init
  scsi: scsi_debug: Support hostwide tags

 drivers/scsi/scsi_debug.c | 79 +++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 12 deletions(-)

-- 
2.26.2

