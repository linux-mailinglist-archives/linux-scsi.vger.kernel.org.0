Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D69B46123
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2019 16:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfFNOl7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Jun 2019 10:41:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728210AbfFNOl7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 Jun 2019 10:41:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E74B0859FC;
        Fri, 14 Jun 2019 14:41:48 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.2.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE1B87C5B6;
        Fri, 14 Jun 2019 14:41:45 +0000 (UTC)
From:   Tomas Henzl <thenzl@redhat.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com, Sathya.Prakash@broadcom.com
Subject: [PATCH 0/2] mpt3sas
Date:   Fri, 14 Jun 2019 16:41:42 +0200
Message-Id: <20190614144144.6448-1-thenzl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 14 Jun 2019 14:41:59 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Just few small changes, octal numbers instead of constants etc.

Tomas Henzl (2):
  scsi: mpt3sas: make driver options visible in sys
  scsi: mpt3sass: use DEVICE_ATTR_{RO, RW}

 drivers/scsi/mpt3sas/mpt3sas_base.c  |  14 +-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c   | 210 +++++++++++++--------------
 drivers/scsi/mpt3sas/mpt3sas_scsih.c |  14 +-
 3 files changed, 111 insertions(+), 127 deletions(-)

-- 
2.20.1

