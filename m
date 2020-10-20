Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623FF293553
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Oct 2020 08:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404609AbgJTG4c (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Oct 2020 02:56:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:39972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731186AbgJTG4c (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 20 Oct 2020 02:56:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ABE2FAEEE;
        Tue, 20 Oct 2020 06:56:31 +0000 (UTC)
Date:   Tue, 20 Oct 2020 08:56:31 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <james.smart@broadcom.com>
Cc:     linux-scsi@vger.kernel.org
Subject: Re: [PATCH v4 00/31] [NEW] efct: Broadcom (Emulex) FC Target driver
Message-ID: <20201020065631.ywok62ou5viboqbw@beryllium.lan>
References: <20201012225147.54404-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012225147.54404-1-james.smart@broadcom.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi James,

On Mon, Oct 12, 2020 at 03:51:16PM -0700, James Smart wrote:
> Review comments welcome!

gcc-10 complains

$ make C=1

  CC [M]  drivers/scsi/elx/libefc/efc_els.o
drivers/scsi/elx/libefc_sli/sli4.c:987:19: warning: incorrect type in assignment (different base types)
drivers/scsi/elx/libefc_sli/sli4.c:987:19:    expected restricted __le16 [usertype] q_id
drivers/scsi/elx/libefc_sli/sli4.c:987:19:    got unsigned short [usertype] q_id

Thanks,
Daniel
