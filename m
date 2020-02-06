Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157F115443B
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Feb 2020 13:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgBFMqq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Feb 2020 07:46:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:45906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgBFMqq (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 6 Feb 2020 07:46:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8EAA9AE2D;
        Thu,  6 Feb 2020 12:46:44 +0000 (UTC)
Date:   Thu, 6 Feb 2020 13:46:44 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     mwilck@suse.com
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 3/3] scsi: qla2xxx: set UNLOADING before waiting for
 session deletion
Message-ID: <20200206124644.kcd2ilfksmjkjppo@beryllium.lan>
References: <20200205214422.3657-1-mwilck@suse.com>
 <20200205214422.3657-4-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205214422.3657-4-mwilck@suse.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Feb 05, 2020 at 10:44:22PM +0100, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> The purpose of the UNLOADING flag is to avoid port login procedures
> to continue when a controller is in the process of shutting down.
> It makes sense to set this flag before starting session teardown.
> The only operations that must be able to continue are LOGO, PRLO,
> and the like.
> 
> Furthermore, use atomic test_and_set_bit() to avoid the shutdown
> being run multiple times in parallel. In qla2x00_disable_board_on_pci_error(),
> the test for UNLOADING is postponed until after the check for an already
> disabled PCI board.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
