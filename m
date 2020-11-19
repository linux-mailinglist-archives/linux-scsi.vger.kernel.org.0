Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEAC2B8EFD
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Nov 2020 10:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgKSJeW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Nov 2020 04:34:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726457AbgKSJeW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 19 Nov 2020 04:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605778461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wbIzix5WGhVnNEtdaMNSqHmVa7xGqppVr2Rm76QTRVQ=;
        b=D2/bVjWnsMQohH/uG5mTE0JsEc9I5xHxW46Jv9cq4IQlPmWoTSxqo0xrjHMY95S1quwUtU
        6s34dXpKwDF4BJFOeHwA6ujx+qlGuGndOl3bt+s6SU41XTEPnqZ9iBCdWOBWMhXJtBbT83
        SJwE47fPTYFlnXpUiaVmsFaahQfIpYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-Z0KY7aGIM5argSoMOwQ4KA-1; Thu, 19 Nov 2020 04:34:17 -0500
X-MC-Unique: Z0KY7aGIM5argSoMOwQ4KA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 554DF18B6140;
        Thu, 19 Nov 2020 09:34:15 +0000 (UTC)
Received: from localhost (ovpn-13-167.pek2.redhat.com [10.72.13.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C59010013BD;
        Thu, 19 Nov 2020 09:34:10 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 00/13] blk-mq/scsi: tracking device queue depth via sbitmap
Date:   Thu, 19 Nov 2020 17:33:49 +0800
Message-Id: <20201119093402.279318-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

scsi uses one global atomic variable to track queue depth for each
LUN/request queue. This way can't scale well when there is lots of CPU
cores and the disk is very fast. Broadcom guys has complained that their
high end HBA can't reach top performance because .device_busy is
operated in IO path.

Replace the atomic variable sdev->device_busy with sbitmap for
tracking scsi device queue depth.

Test on scsi_debug shows this way improve IOPS > 20%. Meantime
the IOPS difference is just ~1% compared with bypassing .device_busy
on scsi_debug via patches[1]

The 1st 6 patches moves percpu allocation hint into sbitmap, since
the improvement by doing percpu allocation hint on sbitmap is observable.
Meantime export helpers for SCSI.

Patch 7 and 8 prepares for the conversion by returning budget token
from .get_budget callback, meantime passes the budget token to driver
via 'struct blk_mq_queue_data' in .queue_rq().

The last four patches changes SCSI for switching to track device queue
depth via sbitmap.

The patchset have been tested by Broadcom, and obvious performance boost
can be observed on megaraid_sas.

V5:
	- add comment on sbitmap_weight()
	- add patch 'megaraid_sas: v2 replace sdev_busy with local counter'
	  for fixing build failure

V4:
	- limit max sdev->queue_depth as max(1024, shost->can_queue)
	- simplify code for moving per-cpu allocation hint into sbitmap

V3:
	- rebase on both for-5.10/block and 5.10/scsi-queue.

V2:
	- fix one build failure


Kashyap Desai (1):
  megaraid_sas: v2 replace sdev_busy with local counter

Ming Lei (12):
  sbitmap: remove sbitmap_clear_bit_unlock
  sbitmap: maintain allocation round_robin in sbitmap
  sbitmap: add helpers for updating allocation hint
  sbitmap: move allocation hint into sbitmap
  sbitmap: export sbitmap_weight
  sbitmap: add helper of sbitmap_calculate_shift
  blk-mq: add callbacks for storing & retrieving budget token
  blk-mq: return budget token from .get_budget callback
  scsi: put hot fields of scsi_host_template into one cacheline
  scsi: add scsi_device_busy() to read sdev->device_busy
  scsi: make sure sdev->queue_depth is <= max(shost->can_queue, 1024)
  scsi: replace sdev->device_busy with sbitmap

 block/blk-mq-sched.c                        |  17 +-
 block/blk-mq.c                              |  38 ++--
 block/blk-mq.h                              |  25 ++-
 block/kyber-iosched.c                       |   3 +-
 drivers/message/fusion/mptsas.c             |   2 +-
 drivers/scsi/megaraid/megaraid_sas.h        |   2 +
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  47 ++++-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c        |   2 +-
 drivers/scsi/scsi.c                         |  13 ++
 drivers/scsi/scsi_lib.c                     |  69 ++++---
 drivers/scsi/scsi_priv.h                    |   3 +
 drivers/scsi/scsi_scan.c                    |  23 ++-
 drivers/scsi/scsi_sysfs.c                   |   4 +-
 drivers/scsi/sg.c                           |   2 +-
 include/linux/blk-mq.h                      |  13 +-
 include/linux/sbitmap.h                     |  85 +++++---
 include/scsi/scsi_cmnd.h                    |   2 +
 include/scsi/scsi_device.h                  |   8 +-
 include/scsi/scsi_host.h                    |  72 ++++---
 lib/sbitmap.c                               | 210 +++++++++++---------
 20 files changed, 427 insertions(+), 213 deletions(-)

Cc: Omar Sandoval <osandov@fb.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>

-- 
2.25.4

