Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FBC29E53
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfEXSsU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:20 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56324 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728920AbfEXSsU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 050E8204197;
        Fri, 24 May 2019 20:48:19 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tvvHX00lY5Yl; Fri, 24 May 2019 20:48:11 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id EBF5F204162;
        Fri, 24 May 2019 20:48:10 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 00/19] sg: v4 interface, rq sharing + multiple rqs
Date:   Fri, 24 May 2019 14:47:50 -0400
Message-Id: <20190524184809.25121-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patchset extends the SCSI generic (sg) driver found in lk 5.2 .
The sg driver has a version number which is visible via an ioctl()
and is bumped from 3.5.36 to 4.0.12 by this patchset.
The additions and changes are described in some detail on this
long webpage:
    http://sg.danny.cz/sg/sg_v40.html
and references are made in various patches to relevant sections in
that document.

This patchset restores some functionality that was in the v2 driver
version and has been broken by some external patch in the interim
period (20 years). That functionality (NO_DXFER) has found new
uses in request sharing. Also functionality that has been dropped
from the bsg driver over the last year is added to this driver in
this patchset (e.g. async/non-blocking v4 interface usage, and
multiple request support).

This patchset is big and can be regarded as a driver rewrite. The
number of lines increases from around 3000 to over 6000. The size
of the module doubles although that can be reduced by turning off
SCSI logging.

TODO: during development, this driver had its own version of
      tracing which has been removed from the final patchset.
      Curiously that tracing code was never used in anger for
      its intended purpose, but the revamped SG_LOG macro was
      used a lot.
      The intention is to add tracing via the 'standard' kernel
      code. The addition is somewhat invasive, both to the sg
      driver (e.g. some otherwise private structures need to
      be made public) and to the tracing subsystem.

Testing:
The sg3_utils package has several extensions in sg3_utils-1.45
beta (revision 824) to support and test the version 4 sg
driver presented in this patchset.
The new and revised testing utilities are outlined on the
same webpage as above in the second half of the section
titled: "15 Downloads and testing".

This patchset is against Martin Petersen's 5.3/scsi-queue
branch. It will also apply to lk 5.1 and probably lk 5.0 .

Douglas Gilbert (19):
  sg: move functions around
  sg: remove typedefs, type+formatting cleanup
  sg: sg_log and is_enabled
  sg: move header to uapi section
  sg: replace rq array with lists
  sg: sense buffer cleanup
  sg: add sg v4 interface support
  sg: add 8 byte SCSI LUN to sg_scsi_id
  sg: expand sg_comm_wr_t
  sg: add sg_ioabort ioctl
  sg: add sg_iosubmit_v3 and sg_ioreceive_v3 ioctls
  sg: add sg_set_get_extended ioctl
  sg: sgat_elem_sz and sum_fd_dlens
  sg: tag and more_async
  sg: add fd sharing , change, unshare
  sg: add shared requests
  sg: add multiple request support
  sg: add slave wait capability
  sg: table of error numbers with meanings

 drivers/scsi/sg.c      | 6790 ++++++++++++++++++++++++++++++----------
 include/scsi/sg.h      |  268 +-
 include/uapi/scsi/sg.h |  475 +++
 3 files changed, 5682 insertions(+), 1851 deletions(-)
 create mode 100644 include/uapi/scsi/sg.h

-- 
2.17.1

