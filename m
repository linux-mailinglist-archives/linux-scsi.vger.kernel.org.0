Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8D51A053B
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Apr 2020 05:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDGDXk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 Apr 2020 23:23:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbgDGDXk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 6 Apr 2020 23:23:40 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3C6EBC4DE5D8D6869322;
        Tue,  7 Apr 2020 11:23:35 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Apr 2020
 11:23:28 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <anil.gurumurthy@qlogic.com>, <sudarsana.kalluru@qlogic.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 0/7] make a bunch of symbols static
Date:   Tue, 7 Apr 2020 11:21:55 +0800
Message-ID: <20200407032202.36789-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix some sparse warnings.

Jason Yan (7):
  scsi: bfa: bfa_svc.c: make two functions static
  scsi: bfa: bfa_core.c: make bfa_isr_rspq() static
  scsi: bfa: bfa_fcpim.c: make two functions static
  scsi: bfa: bfa_fcs_lport.c: make bfa_fcport_get_loop_attr() static
  scsi: bfa: bfa_ioc_ct.c: make two funcitons static
  scsi: bfa: bfad_attr.c: make two funcitons static
  scsi: bfa: bfad.c: make max_rport_logins static

 drivers/scsi/bfa/bfa_core.c      | 2 +-
 drivers/scsi/bfa/bfa_fcpim.c     | 4 ++--
 drivers/scsi/bfa/bfa_fcs_lport.c | 2 +-
 drivers/scsi/bfa/bfa_ioc_ct.c    | 4 ++--
 drivers/scsi/bfa/bfa_svc.c       | 4 ++--
 drivers/scsi/bfa/bfad.c          | 2 +-
 drivers/scsi/bfa/bfad_attr.c     | 4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.17.2

