Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E652ECC6E
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Jan 2021 10:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbhAGJMa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Jan 2021 04:12:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:33262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbhAGJMa (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 7 Jan 2021 04:12:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 951A6ACAF;
        Thu,  7 Jan 2021 09:11:48 +0000 (UTC)
Date:   Thu, 7 Jan 2021 10:11:48 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-scsi@vger.kernel.org, Ram Vegesna <ram.vegesna@broadcom.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 22/31] elx: efct: Hardware queues processing
Message-ID: <20210107091148.bcv3w2vwuaq2kxxt@beryllium.lan>
References: <20210107005030.2929-1-jsmart2021@gmail.com>
 <20210107005030.2929-23-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107005030.2929-23-jsmart2021@gmail.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jan 06, 2021 at 04:50:21PM -0800, James Smart wrote:
> This patch continues the efct driver population.
> 
> This patch adds driver definitions for:
> Routines for EQ, CQ, WQ and RQ processing.
> Routines for IO object pool allocation and deallocation.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> ---
> v6:
>  Ensure an EFCT_HW_XXX status value is returned (not numerical constants)
>  Kernel doc format changes for efct_io structure

Reviewed-by: Daniel Wagner <dwagner@suse.de>
