Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A84523E861
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Aug 2020 09:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHGHya (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Aug 2020 03:54:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:40240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHGHya (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 7 Aug 2020 03:54:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C638EAC4C;
        Fri,  7 Aug 2020 07:54:46 +0000 (UTC)
Date:   Fri, 7 Aug 2020 09:54:28 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Nilesh Javali <njavali@marvell.com>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v2 10/11] Revert "scsi: qla2xxx: Fix crash on
 qla2x00_mailbox_command"
Message-ID: <20200807075428.bzrhqwllvt5ajfhl@beryllium.lan>
References: <20200806111014.28434-1-njavali@marvell.com>
 <20200806111014.28434-11-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806111014.28434-11-njavali@marvell.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Aug 06, 2020 at 04:10:13AM -0700, Nilesh Javali wrote:
> FCoE adapter initialization failed for ISP8021.
> 
> This reverts commit 3cb182b3fa8b7a61f05c671525494697cba39c6a.

But wouldn't this revert not also bring back the crash from 3cb182b3fa8b
("scsi: qla2xxx: Fix crash on qla2x00_mailbox_command"):

    This patch fixes a crash on qla2x00_mailbox_command caused when the driver
    is on UNLOADING state and tries to call qla2x00_poll, which triggers a
    NULL pointer dereference.

