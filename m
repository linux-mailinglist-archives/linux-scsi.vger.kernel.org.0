Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2578341B6
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 10:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfFDIXZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 04:23:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbfFDIXY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 04:23:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C73F22F8BCA;
        Tue,  4 Jun 2019 08:23:24 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98C795B683;
        Tue,  4 Jun 2019 08:23:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/2] scsi: two SG_CHAIN related fixes
Date:   Tue,  4 Jun 2019 16:23:06 +0800
Message-Id: <20190604082308.5575-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 04 Jun 2019 08:23:24 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

Guenter reported scsi boot issue caused by commit c3288dd8c232
("scsi: core: avoid pre-allocating big SGL for data").

Turns out there are at least two issues.

The 1st patch fixes issue in case that NO_SG_CHAIN on some ARCHs,
such as alpha, arm and parisc.

The 2nd patch makes esp scsi working with SG_CHAIN.


Ming Lei (2):
  scsi: core: don't pre-allocate small SGL in case of NO_SG_CHAIN
  scsi: esp: make it working on SG_CHAIN

 drivers/scsi/esp_scsi.c | 32 +++++++++++++++++++++++++-------
 drivers/scsi/scsi_lib.c |  6 +++++-
 2 files changed, 30 insertions(+), 8 deletions(-)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>

-- 
2.20.1

