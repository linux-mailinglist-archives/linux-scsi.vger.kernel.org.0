Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770AF2E9B6F
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Jan 2021 17:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbhADQ6t (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Jan 2021 11:58:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:42282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbhADQ6t (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Jan 2021 11:58:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF085AD57;
        Mon,  4 Jan 2021 16:58:07 +0000 (UTC)
Date:   Mon, 4 Jan 2021 17:58:07 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-scsi@vger.kernel.org, Ram Vegesna <ram.vegesna@broadcom.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v5 17/31] elx: efct: Data structures and defines for hw
 operations
Message-ID: <20210104165807.kyjawfth5jikmbj6@beryllium.lan>
References: <20210103171134.39878-1-jsmart2021@gmail.com>
 <20210103171134.39878-18-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103171134.39878-18-jsmart2021@gmail.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Jan 03, 2021 at 09:11:20AM -0800, James Smart wrote:
> This patch starts the population of the efct target mode
> driver.  The driver is contained in the drivers/scsi/elx/efct
> subdirectory.
> 
> This patch creates the efct directory and starts population of
> the driver by adding SLI-4 configuration parameters, data structures
> for configuring SLI-4 queues, converting from os to SLI-4 IO requests,
> and handling async events.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
