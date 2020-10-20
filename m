Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C61293686
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Oct 2020 10:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387530AbgJTIOc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Oct 2020 04:14:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:56644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgJTIOc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 20 Oct 2020 04:14:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66757AC83;
        Tue, 20 Oct 2020 08:14:31 +0000 (UTC)
Date:   Tue, 20 Oct 2020 10:14:30 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <james.smart@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, Ram Vegesna <ram.vegesna@broadcom.com>
Subject: Re: [PATCH v4 07/31] elx: libefc_sli: APIs to setup SLI library
Message-ID: <20201020081430.uam4vtki2kfv4nsx@beryllium.lan>
References: <20201012225147.54404-1-james.smart@broadcom.com>
 <20201012225147.54404-8-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012225147.54404-8-james.smart@broadcom.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Oct 12, 2020 at 03:51:23PM -0700, James Smart wrote:
> +bool
> +sli_fw_ready(struct sli4 *sli4)
> +{

Why is this and the following function returning a bool? I ask because
the rest of the code uses EFC_FAIL/EFC_SUCCESS. The bool and the EFC_
are defined opposite in their meaning thus we have inconsistent code
patterns:

		if (sli_fw_ready(sli4))
			return true;
vs:

		if (sli_request_features(sli4, &sli4->features, true))
			return EFC_FAIL;


The rest looks good.
Reviewed-by: Daniel Wagner <dwagner@suse.de>
