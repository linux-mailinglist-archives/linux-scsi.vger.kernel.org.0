Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36963F0570
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Aug 2021 15:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbhHRN6r (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 18 Aug 2021 09:58:47 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3663 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhHRN6r (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 18 Aug 2021 09:58:47 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GqTwm1vJxz6D9rf;
        Wed, 18 Aug 2021 21:57:12 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 18 Aug 2021 15:58:10 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 18 Aug 2021 14:58:08 +0100
From:   John Garry <john.garry@huawei.com>
To:     <mdr@sgi.com>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bvanassche@acm.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] scsi: qla1280: Resolve some compilation issues
Date:   Wed, 18 Aug 2021 21:53:19 +0800
Message-ID: <1629294801-32102-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

As another follow-up to removing scsi_cmnd.tag in [0], remove its usage in
the qla1280 driver lurking under a local build switch. Also fix
pre-existing compilation issues under the same switch.

Based on mkp-scsi 5.15 staging at 848ade90ba9c

[0] https://lore.kernel.org/linux-scsi/yq14kbppa42.fsf@ca-mkp.ca.oracle.com/T/#mb47909f38f35837686734369600051b278d124af

John Garry (2):
  scsi: qla1280: Stop using scsi_cmnd.tag
  scsi: qla1280: Fix DEBUG_QLA1280 compilation issues

 drivers/scsi/qla1280.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

-- 
2.17.1

