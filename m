Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3AEE5098
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Oct 2019 17:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395550AbfJYP4g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 25 Oct 2019 11:56:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:51526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388136AbfJYP4g (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 25 Oct 2019 11:56:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE5CFB54D;
        Fri, 25 Oct 2019 15:56:34 +0000 (UTC)
Date:   Fri, 25 Oct 2019 17:56:34 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-scsi@vger.kernel.org
Subject: Re: [PATCH 00/32] [NEW] efct: Broadcom (Emulex) FC Target driver
Message-ID: <20191025155634.eacbiyu5fo77ddet@beryllium.lan>
References: <20191023215557.12581-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191023215557.12581-1-jsmart2021@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi James,

> Review comments welcome!

My compiler is complaining:

home/wagi/work/linux/drivers/scsi/elx/efct/efct_driver.c: In function ‘efct_request_firmware_update’:
/home/wagi/work/linux/drivers/scsi/elx/efct/efct_driver.c:350:3: warning: ‘fw_change_status’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  350 |   switch (fw_change_status) {
      |   ^~~~~~
  CC      drivers/scsi/elx/libefc/efc_device.o
  CC      drivers/scsi/elx/libefc/efc_lib.o
  CC      drivers/scsi/elx/libefc/efc_sm.o
  CC      drivers/scsi/elx/libefc_sli/sli4.o
/home/wagi/work/linux/drivers/scsi/elx/libefc_sli/sli4.c: In function ‘sli_fc_rq_set_alloc’:
/home/wagi/work/linux/drivers/scsi/elx/libefc_sli/sli4.c:818:12: warning: ‘offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  818 |  u32 i, p, offset;
      |            ^~~~~~

Thanks,
Daniel
