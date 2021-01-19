Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4046F2FB4A3
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Jan 2021 09:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbhASI4E (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 Jan 2021 03:56:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:53938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730749AbhASIzy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 19 Jan 2021 03:55:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F03CB815;
        Tue, 19 Jan 2021 08:55:04 +0000 (UTC)
Date:   Tue, 19 Jan 2021 09:55:03 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arun Easi <aeasi@marvell.com>, Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH] scsi: qla2xxx: fix description for parameter
 ql2xenforce_iocb_limit
Message-ID: <20210119085503.wrc3ujjhj7a2kfhs@beryllium.lan>
References: <20210118184922.23793-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118184922.23793-1-ematsumiya@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jan 18, 2021 at 03:49:22PM -0300, Enzo Matsumiya wrote:
> Parameter ql2xenforce_iocb_limit is enabled by default.
> 
> Fixes: 89c72f4245a8 ("scsi: qla2xxx: Add IOCB resource tracking")
> Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

