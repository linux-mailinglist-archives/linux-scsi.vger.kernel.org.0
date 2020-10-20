Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5782936A5
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Oct 2020 10:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbgJTITd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Oct 2020 04:19:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:59538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388222AbgJTITd (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 20 Oct 2020 04:19:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62A5EAC6D;
        Tue, 20 Oct 2020 08:19:32 +0000 (UTC)
Date:   Tue, 20 Oct 2020 10:19:31 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <james.smart@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, Ram Vegesna <ram.vegesna@broadcom.com>
Subject: Re: [PATCH v4 08/31] elx: libefc: Generic state machine framework
Message-ID: <20201020081931.ko6lwdge3v2o6avh@beryllium.lan>
References: <20201012225147.54404-1-james.smart@broadcom.com>
 <20201012225147.54404-9-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012225147.54404-9-james.smart@broadcom.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Oct 12, 2020 at 03:51:24PM -0700, James Smart wrote:
> This patch starts the population of the libefc library.
> The library will contain common tasks usable by a target or initiator
> driver. The library will also contain a FC discovery state machine
> interface.
> 
> This patch creates the library directory and adds definitions
> for the discovery state machine interface.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <james.smart@broadcom.com>

Looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
