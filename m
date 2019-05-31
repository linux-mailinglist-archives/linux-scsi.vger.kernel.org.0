Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D00C30DEC
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 14:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfEaMPE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 08:15:04 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:35543 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEaMPE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 May 2019 08:15:04 -0400
Received: by mail-ed1-f49.google.com with SMTP id p26so14294221edr.2
        for <linux-scsi@vger.kernel.org>; Fri, 31 May 2019 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+g4N+Uw8+J/xrlpeIndzR0y7xIoJvBbSrZvEQyE3//I=;
        b=DghypWyXl5JYQGuV/SdgHl9HVshoOtsSZz131LVWAYeZRAMkSkeStmlYc4XEywrSy0
         gGlpGNdGW5anTslx76KKpgsarxHfWH5TOA5pV2xdyTy9MS6Xx5wPqZNfhqpMvE2zG/Wi
         6i29LAFK6dfXbHaMbtHq7nJcO0yG3LrbqRsz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+g4N+Uw8+J/xrlpeIndzR0y7xIoJvBbSrZvEQyE3//I=;
        b=k2M5XGpaIK9HOpMUB/CsdFhNnpQoAwVsAR1MPkbOZFl4TdQsO7QLXRKwJI3WHEQeHi
         NuTsEPgAL2rvv9475PyK9X7OT6kEpnEd4jcbsG9rXms3DVx6r13e5LUpuYJ/63gySGU/
         egc23P0S0hH5ElkRfOtUMGJ4WmTX+kNaBKh4vcH2Xfbq+ElEGpizsfkNdFkmKOC1ALAY
         mpP2F7KM5Eb5yb7oz2LzzKP3XbQIl1SpwQTUDlXesvFvrlURGBsBX4He0YGCSXRRVpIx
         1PesnGOew8qmoevYIgEsQhpObo3ZWuX2H1j/khBk6C9pCQnHUAWKyMoW/qLe/l6ro6nu
         RrWw==
X-Gm-Message-State: APjAAAUkFhc98jyOEOIHHyu94U6K+6APsKv5t17fi9joMwCu23OYRQEA
        GSVZqEDvNcVGmICwanJsNPfazyxqLArKOYjrMZk99ETVxhpoFJTjDowywYUvTOgV1NhCfoWJwKy
        TRvK3MhBV0FOxu5IELBQX453o5seyk+UMuKrw4b8BxjacBiiL7P4dDhQXhGAfe/EkKR7j7I2/ZQ
        CnWvmgG/sN3S2I5bGSjw==
X-Google-Smtp-Source: APXvYqzwlM2ASW/2/u29ghS8OJJBVeAMPxCTs7EfMQOYqFcRd8shrPl5oJpJAS29oe4YBbGsN0k2UA==
X-Received: by 2002:a50:c102:: with SMTP id l2mr11001391edf.185.1559304901727;
        Fri, 31 May 2019 05:15:01 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jz15sm822186ejb.75.2019.05.31.05.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 05:15:00 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     kashyap.desai@broadcom.com, sreekanth.reddy@broadcom.com,
        Sathya.Prakash@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [V3 00/10] mpt3sas: Aero/Sea HBA feature addition
Date:   Fri, 31 May 2019 08:14:33 -0400
Message-Id: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In this patch series we are adding below two features for
Aero/Sea HBA device. Aero/Sea series HBA is PCI4.0 based controllers.

1. Add Atomic Request descriptor support:
Atomic Request Descriptor is an alternative method for posting
an entry onto a request queue. The posting of an Atomic
Request Descriptor is an atomic operation.

2. Max Performance using balanced performance mode. 
(~3.0 Million IOPs for Random Read/Write):

Aero Hardware interrupt coalescing behavior:

H/W Interrupt coalescing is effective within a group of reply queue.
Each reply queue group consists of 8 reply queues. This particular
h/w interface allows to configure mixture of interrupt coalescing
on/off per controller. In 128 vector mode, every 8 MSI-x vectors will be
grouped together. If a reply is sent to a MSI-x vector not in the
present group, h/w will flush all outstanding IOS.

Below are some examples to understand h/w interrupt coalescing behavior.
Let’s consider some simple io submission and completion flow to
understand h/w interrupt coalescing behavior.
Reply queue starts with index 0. Reply return from back end device
in the same order as it was submitted (this just to explain
simple case). Reply queue 0-7 is one interrupt coalescing group.
Another interrupt coalescing group is 8-15. Let’s consider that
CoalescingTimeout is max value just to explain h/w behavior.
CoalescingDepth = 0x4 and CoalescingTimeout = 0xFFFF.

Coalescing timeout:
Reply coalescing timeout in units of one-half of a microsecond
(500 nanoseconds). When the amount of time from the first pending
reply exceeds this value, the IOC sends the replies to the host
using a single interrupt.

Coalescing Depth:
This field specifies the reply coalescing depth. When the
number of pending replies exceeds this number, the IOC sends the
replies to the host using a single interrupt.

1. Driver has submitted 4 IOS to firmware for targeted reply queue groups
4, 5, 6, and 7. In this case, OS will receive 4 interrupt for 4
replies. Interrupt on reply queue group 4, 5, 6 is due to next
io completion is on different msix vector group. Interrupt on reply
queue 7 is due to coalescing timeout criteria (as their are no IOs
after this).

2. Driver has submitted 4 IOS to firmware for targeted reply
queues group 4, 4, 6, and 6. In this case, OS will receive 2 interrupt
for 4 replies. First interrupt on reply queue group 4 will be before
coalescing timeout elapsed. Since next io completion is on a
different msix vector group, interrupt on reply queue group 6 will be
after coalescing timeout elapsed.

3. Driver has submitted 6 IOS to firmware for targeted reply queue
group 4, 4, 4, 4, 4 and 5. In this case, OS will receive 3 interrupt for 6
replies. First Interrupt on reply queue 4 will be before coalescing
timeout elapsed due to coalesced depth criteria meet. Second Interrupt
on reply queue 4 will be before coalescing timeout elapsed, since next
io completion is on different msix vector. Third interrupt on reply
queue group 5 will be after coalescing timeout elapsed.

Balanced performance interface for Aero/Sea:

Driver will use combination of interrupt coalescing and no
interrupt coalescing in h/w. Driver will create few high
iops queue to get high IOPs on Aero/Sea family controllers.
Low latency queues are queues without interrupt coalsecing.
High iops queue are special queue which has interrupt coalescing ON
(e.a 0x4 Coalescing depth and 0x20 Coalescing Timeout). In general,
high iops queue and low latency queue together should fit into 128
reply queue (max reply queue supported by Aero/Sea).
Driver should pick only few high iops queue because it should not
change low latency io path as much as possible and at the same time
few high iops queue should be good enough to get the high iops numbers.

High level design of creating number of high iops queues:
If there are unused reply queue left in the system due to logical cpu
count is less than firmware supported msix vectors, driver should increase
effective reply queues.

Example: 2 socket server (total 72 logical CPU).
There are total 56 reply queue unmapped in that system.

Driver should map low latency reply queue starting from 8 to 79
and should map high iops reply queue starting from 0 to 7.

If #online cpus are more than or equal to 120 (derives from #total msix
supported by firmware minus high iops queue), allocate 128 reply queues.
Driver should map low latency reply queue starting from 8 to 127.
Driver should map high iops reply queue starting from 0 to 7.
If driver is not able to allocate required reply queues, it should fall
back to legacy mode (without high iops queue)

IO submission (Below is applicable only if high iops queue is enabled):

If outstanding IOs per scsi device is less than or equal to 8,
use legacy io path (i.e use low latency reply queue).
If outstanding IOs per scsi device is more than  8 -
Driver should do round robin io submission in batches on high iops queue.

Example: Batches of the 16.
“First 16 IOS submitted to reply queue 0, next 16 IOS submitted to reply
queue 1 etc”.

v2:
- Fix sparse warnings reported by kbuild test robot

v3:
- In patch6, For readability use if statement instead
of ternary operator.

Suganath Prabu S (10):
  mpt3sas: function pointers of request descriptor
  mpt3sas: Add Atomic RequestDescriptor support on Aero
  mpt3sas: Add flag high_iops_queues
  mpt3sas: change _base_get_msix_index prototype
  mpt3sas: Use highiops queues if more in-flights
  mpt3sas:save msix index and use same while posting RD
  mpt3sas: Affinity high iops queues IRQs to local node
  mpt3sas: Enable interrupt coalescing on high iops
  mpt3sas: Introduce perf_mode module parameter
  mpt3sas: Update driver version to 29.100.00.00

 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h     |   2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c      | 476 ++++++++++++++++++++---
 drivers/scsi/mpt3sas/mpt3sas_base.h      |  34 +-
 drivers/scsi/mpt3sas/mpt3sas_config.c    |  73 +++-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c       |  20 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     |  38 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c |   8 +-
 7 files changed, 574 insertions(+), 77 deletions(-)

-- 
2.18.1

