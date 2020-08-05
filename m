Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4984B23C288
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Aug 2020 02:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgHEAQn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Aug 2020 20:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgHEAQm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Aug 2020 20:16:42 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D88C06174A
        for <linux-scsi@vger.kernel.org>; Tue,  4 Aug 2020 17:16:42 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 25so14449905oir.0
        for <linux-scsi@vger.kernel.org>; Tue, 04 Aug 2020 17:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=tlaYwYCe4OZCejQbMYs2u0Xxn0ktVuFV1VwXoIMFOjHGQwjyLNcoBYxhfGfYy7BGWk
         gmB6+3nn057k3kkmIRg5CLBOi/Zlt/DIXTnu4gLBimW3TRimfKAfx9Q8DFDw3jcMRw7z
         ouCa+n2hnlvhxywg03pLY+RY1d/bAL+waGXTgTk6DeLK+lGAYy94eEUThe0MROupX6BK
         W4beIuw9731C9QFjElHkGDv4T/n6nxhCniqztPLr7Fn90+QPU3cuXaIvqkfs9lgK2Dp8
         SEKzRQJCQWwDeSD7xsbn3NJIWxl0Xe6tbimsseMnEMpxtEKJk1OAuZgRo22ATGZHestB
         nAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=JqftKt39rQsX/WM7UgUicXCLecP5QL45m7pga9Of9B4M7pirTSxgIdlBE+pM38D199
         i7csW9NLXGpLc8hwXeH9uiWuwNVHq4WzpVl1SAdSF9PNqjokbyAdV3OUR7CQFfv6qH5y
         lpvsQjxvNSK3QUBijBpgtCwcBeTHbvBrnU+2pLeUSLCV5BSwlgj88lF9yhs6APk51pSI
         mw4CrLQRFRRJtovuFzu/93Sz5pMvr8fMcyDd6J/QCs9qDULM9fKgs4DjONmoBb1Jzqld
         Tk15BODonAHILTTko+d3d7lgNxsPLn02WONvl8MK5zSgmOJmQ/FSJQmd9EeqZ83im7r/
         hRow==
X-Gm-Message-State: AOAM5310VKm3mxM0G/j62MUJOO8Rm78fFE2Ut2TErgSU/drCzosfCifs
        hwjqknGrCpIg1StDr8EONcdzbGR7WSYftpO7BIg=
X-Google-Smtp-Source: ABdhPJxCvDh0dllqqnAWzr6/gFl3mWtIxvEf/S5Z5pZHs/hnY9wI/ArZ7K6H/oZQEsm46QKI8kyXTaN1jFSe9KgozFM=
X-Received: by 2002:aca:f106:: with SMTP id p6mr720707oih.169.1596586601538;
 Tue, 04 Aug 2020 17:16:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:809:0:0:0:0 with HTTP; Tue, 4 Aug 2020 17:16:41
 -0700 (PDT)
Reply-To: sylviarobinson.usa@hotmail.com
From:   Sylvia Robinson <lorirobison402@gmail.com>
Date:   Wed, 5 Aug 2020 01:16:41 +0100
Message-ID: <CAJ2n05F6ydrJWsbUJez856N4nWZU_jVV3+z3Z7Qb6-LGsXQT2g@mail.gmail.com>
Subject: =?UTF-8?B?5oKo5aW977yM5oKo55yL5Yiw5oiR5Y+R57uZ5oKo55qE5raI5oGv5LqG5ZCX77yf?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


