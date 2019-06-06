Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2408D36EC1
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 10:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfFFIea (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 04:34:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfFFIe3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 6 Jun 2019 04:34:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61AAB6147C;
        Thu,  6 Jun 2019 08:34:21 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A406101E69F;
        Thu,  6 Jun 2019 08:34:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH V3 0/3] scsi: three SG_CHAIN related fixes
Date:   Thu,  6 Jun 2019 16:34:07 +0800
Message-Id: <20190606083410.32243-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 06 Jun 2019 08:34:29 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

Guenter reported scsi boot issue caused by commit c3288dd8c232
("scsi: core: avoid pre-allocating big SGL for data").

Turns out there are at least three issues.

The 1st patch fixes sg_alloc_table_chained() which may try to use
the pre-allocation SGL even though user passes zero to 'nents_first_chunk'.

The 2nd patch fixes issue in case that NO_SG_CHAIN on some ARCHs,
such as alpha, arm and parisc.

The 3rd patch makes esp scsi working with SG_CHAIN.

V3:
	- add reviewed-by & tested-by tag
	- update 1st patch's commit log & kernel doc

V2:
	- add the patch1, which is verified by Guenter
	- add .prv_sg to store the previous sg for esp_scsi


Ming Lei (3):
  scsi: lib/sg_pool.c: clear 'first_chunk' in case of no pre-allocation
  scsi: core: don't pre-allocate small SGL in case of NO_SG_CHAIN
  scsi: esp: make it working on SG_CHAIN

 drivers/scsi/esp_scsi.c | 20 +++++++++++++-------
 drivers/scsi/esp_scsi.h |  2 ++
 drivers/scsi/scsi_lib.c |  6 +++++-
 lib/sg_pool.c           |  6 ++++--
 4 files changed, 24 insertions(+), 10 deletions(-)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Guenter Roeck <linux@roeck-us.net>
-- 
2.20.1

