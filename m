Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69652A1049
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Oct 2020 22:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgJ3Vjx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 30 Oct 2020 17:39:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:56804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgJ3Vjw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 30 Oct 2020 17:39:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA4DFADDB;
        Fri, 30 Oct 2020 21:39:50 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org
Subject: [PATCH v2 0/4] scsi: target: COMPARE AND WRITE miscompare sense
Date:   Fri, 30 Oct 2020 22:39:27 +0100
Message-Id: <20201030213931.10720-1-ddiss@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patchset adds missing functionality to return the offset of
non-matching read/compare data in the sense INFORMATION field on
COMPARE AND WRITE miscompare.

The functionality can be tested using the libiscsi
CompareAndWrite.MiscompareSense test proposed via:
  https://github.com/sahlberg/libiscsi/pull/344

Changes since v2:
- perform bad_sector->sense_info rename in overlooked ib_isert
- drop scatterlist change queued via Jens' tree
- add Mike's reviewed-by tag
- rebase against Martin's 5.11/scsi-queue branch

Changes since v1:
- drop unnecessary WARN_ON()
- fix two checkpatch warnings
- drop single-use nlbas variable
- avoid compare_len recalculation

Cheers, David

 drivers/infiniband/ulp/isert/ib_isert.c |   4 +-
 drivers/target/target_core_sbc.c        | 137 ++++++++++++++----------
 drivers/target/target_core_transport.c  |  33 +++---
 include/target/target_core_base.h       |   2 +-
 4 files changed, 103 insertions(+), 73 deletions(-)

