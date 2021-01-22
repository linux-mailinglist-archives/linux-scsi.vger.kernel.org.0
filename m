Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEC3301041
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Jan 2021 23:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbhAVWnz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 Jan 2021 17:43:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:51838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbhAVWnh (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 22 Jan 2021 17:43:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2315AE40;
        Fri, 22 Jan 2021 22:42:52 +0000 (UTC)
Date:   Fri, 22 Jan 2021 23:42:51 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux@yadro.com>, Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH v2] scsi: target: core: check SR field in REPORT LUNS
Message-ID: <20210122234251.595d5b7a@suse.de>
In-Reply-To: <20210120102700.5514-1-d.bogdanov@yadro.com>
References: <20210120102700.5514-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

On Wed, 20 Jan 2021 13:27:00 +0300, Dmitry Bogdanov wrote:

> Now REPORT LUNS for software device servers always reports all luns
> regardless of SELECT REPORT field.
> Add handling of that field according to SPC-4:
> * accept known values,
> * reject unknown values.

We currently advertise SPC-3 VERSION compliance via standard INQUIRY
data, so I think we should either support SPC-3 SELECT REPORT values or
bump the VERSION field (SPC-4 behaviour is already scattered throughout
LIO).
Out of curiosity, do you know of any initiators which use this field?

Cheers, David
