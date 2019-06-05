Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEB4354D6
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 03:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFEBGj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 21:06:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfFEBGj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 21:06:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1924FBB10;
        Wed,  5 Jun 2019 01:06:34 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02DED1001E63;
        Wed,  5 Jun 2019 01:06:30 +0000 (UTC)
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
Subject: [PATCH V2 0/3] scsi: three SG_CHAIN related fixes
Date:   Wed,  5 Jun 2019 09:06:20 +0800
Message-Id: <20190605010623.12325-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 05 Jun 2019 01:06:39 +0000 (UTC)
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
 lib/sg_pool.c           |  2 +-
 4 files changed, 21 insertions(+), 9 deletions(-)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Guenter Roeck <linux@roeck-us.net>


-- 
2.20.1

