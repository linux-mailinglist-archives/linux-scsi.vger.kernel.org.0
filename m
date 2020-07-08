Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6782186FA
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Jul 2020 14:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgGHMMO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 Jul 2020 08:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgGHMMN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 8 Jul 2020 08:12:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682E9C08E6DC
        for <linux-scsi@vger.kernel.org>; Wed,  8 Jul 2020 05:12:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so48760482wrv.9
        for <linux-scsi@vger.kernel.org>; Wed, 08 Jul 2020 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dSkqKeCZdW90TMEdN9Flg+YLJ8bt6+9TzGKCz9DbybY=;
        b=zLDzhhyoreQIgEIR+ugQTfkKH6LFYLjo4qAI1sYIrgLdTPOOh3JOZs8KwZZPSQy4KV
         hy9OApK1AgcwFoenOaV33cNHbCOgmN0UOoWlJmVO2YGDMonyIjBkSAvHifjPCHQwROpv
         pOPrOS3R7g2YUNMHAk6wDbmgHvE7C+djIhTe7qg8SJB7O7S87v8hh/sOtJ9/mxY1Sin5
         PjCePV5bktTU06z9dpLw2dHoBZKb7qtaS9nj+iRlV6p35Gu5OAyRb5XjvHtJwYlVECB5
         b3+EYzR4g9A4hCWTCkGxnuVVhjliGkx+qPXcqtGolTTc11MW+ccNQn5wRRjfX3J1EROb
         bH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dSkqKeCZdW90TMEdN9Flg+YLJ8bt6+9TzGKCz9DbybY=;
        b=QIO5QjPHut8BmbPOw7q3/N+FOPPycqo78ruLYFg/XF8aggnU8yRqpH8goMdFt0Ml9O
         P/6ojSCsPi0CVH1cSZBw2NsJKoupcbQFeJFl7zMBgW4LLgRuWO1xFrvWF6aMCgagmax6
         Yhf1Nvzq8RazeEu+A3vlA/Iu8xfQNRhoWYvhFF7DjZ8YjfrVAFFd/5ZQuDEn4yWUWTo2
         O9aEQ9Qufwdf811A1bLWzuKmBHE6x8JOdDvReYen5rmEYAZtbNCBQAv5S2RlElTPXHC+
         +tf+euNm9d/l6Gj5Y2ynC5TuEanjVui9n+vdOU1tPt845ht0qRXmMVCYEhBIznDF4zmR
         kd3A==
X-Gm-Message-State: AOAM531YAF9DX5yYR11T55SOn+Z+DyDnHljJ+Cl2a8aar16MIvIsfaLl
        BZh8ffXflbK2NDx+7sf2FxU2aA==
X-Google-Smtp-Source: ABdhPJyqs3RsyDoSQ2yeKo0pKmqEfzGMbFQvw9N5l4jbOqxFffm4z8X+KKhpGC42G5O+NaxRNj/wpQ==
X-Received: by 2002:a5d:54c9:: with SMTP id x9mr61729854wrv.247.1594210332080;
        Wed, 08 Jul 2020 05:12:12 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id t141sm6455156wmt.26.2020.07.08.05.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:12:11 -0700 (PDT)
Date:   Wed, 8 Jul 2020 13:12:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 03/30] scsi: libfc: fc_disc: trivial: Fix spelling
 mistake of 'discovery'
Message-ID: <20200708121209.GS3500@dell>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
 <20200708120221.3386672-4-lee.jones@linaro.org>
 <SN4PR0401MB35986D7CECA87EA6EB9CEFA99B670@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN4PR0401MB35986D7CECA87EA6EB9CEFA99B670@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 08 Jul 2020, Johannes Thumshirn wrote:

> Looks good,
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> I think Martin can fold this one into the original one

Obviously I'd be okay with that, but it will depend on whether his
tree is able to be rebased.  Many public trees are unrebasable (if
that's a word).

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
