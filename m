Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE17B77644
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Jul 2019 05:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfG0Dhm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 23:37:42 -0400
Received: from smtp.infotech.no ([82.134.31.41]:54530 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfG0Dhm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 23:37:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id D9BE620419A;
        Sat, 27 Jul 2019 05:37:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LxYwiTblA3EN; Sat, 27 Jul 2019 05:37:34 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 72CFD20417C;
        Sat, 27 Jul 2019 05:37:32 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH v2 00/18] sg: add v4 interface
Date:   Fri, 26 Jul 2019 23:37:10 -0400
Message-Id: <20190727033728.21134-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patchset extends the SCSI generic (sg) driver found in lk 5.3 .
The sg driver has a version number which is visible via
ioctl(SG_GET_VERSION_NUM) and is bumped from 3.5.36 to 4.0.03 by this
patchset. The additions and changes are described in some detail in
this long webpage:
    http://sg.danny.cz/sg/sg_v40.html

Most new features described in the above webpage are not implemented
in this patchset. Features that are not included are file descriptor
sharing, request sharing, multiple requests (in one invocation) and
the extended ioctl(). A later patchset may add those features. The
SG_IOSUMIT, SG_IOSUBMIT_V3, SG_IORECEIVE and SG_IORECEIVE_V3 ioctls
are added in this patchset.

Testing:
The sg3_utils package has several extensions in sg3_utils-1.45 beta
(revision 829 (see http://sg.danny.cz/sg)) to support and test the
version 4 sg driver presented in this patchset.
The new and revised testing utilities are outlined on the
same webpage as above in the second half of the section
titled: "15 Downloads and testing".

This patchset is against Martin Petersen's 5.4/scsi-queue branch.
To apply this patchset to lk 5.2 and earlier, the ktime_get_boottime_ns()
call needs to be changed back to ktime_get_boot_ns().

Changes since v1 (sent to linux-scsi list on 20190616):
  - change ktime_get_boot_ns() to ktime_get_boottime_ns() to reflect
    kernel API change first seen in lk 5.3.0-rc1


Douglas Gilbert (18):
  sg: move functions around
  sg: remove typedefs, type+formatting cleanup
  sg: sg_log and is_enabled
  sg: rework sg_poll(), minor changes
  sg: bitops in sg_device
  sg: make open count an atomic
  sg: move header to uapi section
  sg: speed sg_poll and sg_get_num_waiting
  sg: sg_allow_if_err_recovery and renames
  sg: remove most access_ok functions
  sg: replace rq array with lists
  sg: sense buffer rework
  sg: add sg v4 interface support
  sg: rework debug info
  sg: add 8 byte SCSI LUN to sg_scsi_id
  sg: expand sg_comm_wr_t
  sg: add sg_iosubmit_v3 and sg_ioreceive_v3 ioctls
  sg: bump version to 4.0.03

 drivers/scsi/sg.c      | 4373 ++++++++++++++++++++++++++--------------
 include/scsi/sg.h      |  268 +--
 include/uapi/scsi/sg.h |  373 ++++
 3 files changed, 3269 insertions(+), 1745 deletions(-)
 create mode 100644 include/uapi/scsi/sg.h

-- 
2.17.1

