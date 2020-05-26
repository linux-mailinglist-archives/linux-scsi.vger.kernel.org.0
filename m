Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 269BA1A0A1F
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Apr 2020 11:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgDGJaF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 Apr 2020 05:30:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12618 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbgDGJaF (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 7 Apr 2020 05:30:05 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5319FCA88C6D9D17D22F;
        Tue,  7 Apr 2020 17:30:03 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Apr 2020
 17:29:53 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <megaraidlinux.pdl@broadcom.com>,
        <linux-scsi@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 0/4] scsi: megaraid: make a bunch of symbols static
Date:   Tue, 7 Apr 2020 17:28:23 +0800
Message-ID: <20200407092827.18074-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make a bunch of symbols static to fix some sparse warnings.

Jason Yan (4):
  scsi: megaraid: make two symbols static in megaraid_mbox.c
  scsi: megaraid: make some symbols static in megaraid_sas_fp.c
  scsi: megaraid: make some symbols static in megaraid_sas_fusion.c
  scsi: megaraid: make two symbols static in megaraid_sas_base.c

 drivers/scsi/megaraid/megaraid_mbox.c       |  6 +++---
 drivers/scsi/megaraid/megaraid_sas_base.c   |  4 ++--
 drivers/scsi/megaraid/megaraid_sas_fp.c     | 12 ++++++------
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.17.2

