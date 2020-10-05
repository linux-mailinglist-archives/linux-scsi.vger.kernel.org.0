Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A48283104
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Oct 2020 09:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJEHm4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Oct 2020 03:42:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:39398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgJEHm4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 5 Oct 2020 03:42:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28728ACBA;
        Mon,  5 Oct 2020 07:42:55 +0000 (UTC)
Date:   Mon, 5 Oct 2020 09:42:54 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Nilesh Javali <njavali@marvell.com>, Arun Easi <aeasi@marvell.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qla2xxx: Do not consume srb greedily
Message-ID: <20201005074254.2f5vgauk5tfwad35@beryllium.lan>
References: <20200929073802.18770-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929073802.18770-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Sep 29, 2020 at 09:38:02AM +0200, Daniel Wagner wrote:
> qla2xx_process_get_sp_from_handle() will clear the slot which the
> current srb is stored. So this function has a side effect. Therefore,
> we can't use it in qla24xx_process_mbx_iocb_response() to check
> for consistency and later again in qla24xx_mbx_iocb_entry().
> 
> Let's move the consistency check directly into
> qla24xx_mbx_iocb_entry() and avoid the double call or any open coding
> of the qla2xx_process_get_sp_from_handle() functionality.
> 
> Fixes: 31a3271ff11b ("scsi: qla2xxx: Handle incorrect entry_type entries")
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> Hi,
> 
> Brown bag for me please. My test patch had an open coded version of
> qla2xx_process_get_sp_from_handle() which didn't consume the srb. When
> I prepared it for sending it out, I 'cleaned' it up by using
> qla2xx_process_get_sp_from_handle() twice.

Ping.
