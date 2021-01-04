Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FF62E96D4
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Jan 2021 15:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbhADOJt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Jan 2021 09:09:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:50810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbhADOJs (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Jan 2021 09:09:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5AD9CAD4E;
        Mon,  4 Jan 2021 14:09:07 +0000 (UTC)
Date:   Mon, 4 Jan 2021 15:09:06 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-scsi@vger.kernel.org, Ram Vegesna <ram.vegesna@broadcom.com>
Subject: Re: [PATCH v5 09/31] elx: libefc: Emulex FC discovery library APIs
 and definitions
Message-ID: <20210104140906.dfhxvlz7twh7sxlu@beryllium.lan>
References: <20210103171134.39878-1-jsmart2021@gmail.com>
 <20210103171134.39878-10-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103171134.39878-10-jsmart2021@gmail.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Jan 03, 2021 at 09:11:12AM -0800, James Smart wrote:
> This patch continues the libefc library population.
> 
> This patch adds library interface definitions for:
> - SLI/Local FC port objects
> - efc_domain_s: FC domain (aka fabric) objects
> - efc_node_s: FC node (aka remote ports) objects
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> 
> ---
> v5:
>  Added Mempool for ELS ios.
>  Remove EFC_HW_NODE_XXX and EFC_HW_NPORT_XXX events.
>  Use EFC_EVT_XXX events directly for port and node callbacks.
> ---
>  drivers/scsi/elx/libefc/efc.h     |  69 ++++
>  drivers/scsi/elx/libefc/efc_lib.c |  81 ++++
>  drivers/scsi/elx/libefc/efclib.h  | 601 ++++++++++++++++++++++++++++++

Is there a reason efclib.h and the c file is called efc_lib.c ?

Anyway, rest looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
