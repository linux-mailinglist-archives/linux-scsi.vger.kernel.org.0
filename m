Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53EB6603B0
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Jan 2023 16:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjAFPuz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 6 Jan 2023 10:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjAFPuy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 6 Jan 2023 10:50:54 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C556611A27
        for <linux-scsi@vger.kernel.org>; Fri,  6 Jan 2023 07:50:49 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id i20so2295162qtw.9
        for <linux-scsi@vger.kernel.org>; Fri, 06 Jan 2023 07:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lXpoIfaZTxbS2QRN9RfCIEN9vyUFx7ZzXfKlV5Axnk=;
        b=VczK0CKG873/g1w+1QU8CxC4ftcvgTK9vA6BMHGenhPMKFhjsXkZRbfOT4pEoXQCA1
         lnG4mSp0PSQd2JDN7/u2OQ5wQ+CjOLSGcKZsUVwFW9Gk35pOGpqVOKYHxg+wJnvtojqO
         aNSI0T2LMzmupUZ24i3q2hpCtGbnNx/SLO5PwdCXckdTW7A2lYCzEHO8VfwppiAZF05E
         npc0j05wJsy4kyjjrKACUrExn4tf4EKaYdmCYm8InQvddpW10ZoehOlw5H+SOwPluG3R
         MECpiIemvkgGMixzlYaPbtx4dbQ3HGKVp2yipd2vwrngoyI4A6QLf24YRRhNRs4HEh3f
         PZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lXpoIfaZTxbS2QRN9RfCIEN9vyUFx7ZzXfKlV5Axnk=;
        b=TYdtIct/bsE3zxXIMpZJK+7WgWGIdU1y4xYE3quXx9kIi+7TKs12VQ6G5+/iP0gA5e
         VBajVrScbYv6ZY38/S3QB8364/pqwul1+ZAFONetu84XciLeOCdcWnvbxj/JmsCRsX8q
         YL/iuisakVI4FZ79HQG9/I9qy02veoIF2hIBRPmFj941ZC25tGuO2/wmvL5FRS5pntNI
         me13QIscC2myMslKwQmVW0Nr97dCJR5HP4a13fKsIRLG/2sP1CfK8yBO608SEmB8ZzeY
         de5whBgPtSjE5Y3sbEhsNstMFBDD4KIoP/XwImUKTtxK6UsoIkD5tyLeVsf/07qR8hEv
         tWKQ==
X-Gm-Message-State: AFqh2kqIcwHV088es5e+Qiubf9KtBnsuzS0jhFmBTwXmxKDzspBb/o0D
        t1R9/xnqYj7zqkX4olZN5aKWaw==
X-Google-Smtp-Source: AMrXdXtc7PWmTSHdCDcPJ2d/kmBDEJP1055b985rDFtVppY/PUVNujWwHos/D72bfVswPQ2KbSH8Mw==
X-Received: by 2002:a05:622a:1f14:b0:3a5:43af:d7ac with SMTP id ca20-20020a05622a1f1400b003a543afd7acmr83801465qtb.67.1673020248733;
        Fri, 06 Jan 2023 07:50:48 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s13-20020ac85ecd000000b003a69de747c9sm664205qtx.19.2023.01.06.07.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 07:50:48 -0800 (PST)
Date:   Fri, 6 Jan 2023 10:50:46 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     lsf-pc@lists.linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: LSF/MM/BPF: 2023: Call for Proposals
Message-ID: <Y7hDVliKq+PzY1yY@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2023 will be held from May 8 to May 10 at the
Vancouver Convention Center in Vancouver, British Columbia, Canada.
LSF/MM/BPF is an invitation-only technical workshop to map out
improvements to the Linux storage, filesystem, BPF, and memory
management subsystems that will make their way into the mainline kernel
within the coming years.

LSF/MM/BPF 2023 will be a three day, stand-alone conference with four
subsystem-specific tracks, cross-track discussions, as well as BoF and
hacking sessions.

	https://events.linuxfoundation.org/lsfmm/

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please point
that out in your proposal or request to attend, and submit the topic as
soon as possible.

We're asking that you please let us know you want to be invited by March
1, 2023.  We realize that travel is an ever changing target, but it
helps us get an idea of possible attendance numbers.  Clearly things can
and will change, so consider the request to attend deadline more about
planning and less about concrete plans.

1) Fill out the following Google form to request attendance and
suggest any topics

	https://forms.gle/VKVXjWGBHZbnsz226

In previous years we have accidentally missed people's attendance
requests because they either didn't cc lsf-pc@ or we simply missed them
in the flurry of emails we get.� Our community is large and our
volunteers are busy, filling this out will help us make sure we don't
miss anybody.

2) Proposals for agenda topics should still be sent to the following
lists to allow for discussion among your peers.� This will help us
figure out which topics are important for the agenda.

� � � ��lsf-pc@lists.linux-foundation.org

and CC the mailing lists that are relevant for the topic in question:

� � � � FS:� � �linux-fsdevel@vger.kernel.org
� � � � MM:� � �linux-mm@kvack.org
� � � � Block:��linux-block@vger.kernel.org
� � � � ATA:� ��linux-ide@vger.kernel.org
� � � � SCSI:� �linux-scsi@vger.kernel.org
� � � � NVMe:� �linux-nvme@lists.infradead.org
� � � � BPF:� ��bpf@vger.kernel.org

Please tag your proposal with [LSF/MM/BPF TOPIC] to make it easier to
track. In addition, please make sure to start a new thread for each
topic rather than following up to an existing one. Agenda topics and
attendees will be selected by the program committee, but the final
agenda will be formed by consensus of the attendees on the day.

3) This year we would like to try and make sure we are including new
members in the community that the program committee may not be familiar
with.  The Google form has an area for people to add required/optional
attendees.  Please encourage new members of the community to submit a
request for an invite as well, but additionally if maintainers or long
term community members could add nominees to the form it would help us
make sure that new members get the proper consideration.

For discussion leaders, slides and visualizations are encouraged to
outline the subject matter and focus the discussions. Please refrain
from lengthy presentations and talks; the sessions are supposed to be
interactive, inclusive discussions.

The COVID related restrictions can be found here, however at this time
there are no protocols defined.

	https://events.linuxfoundation.org/lsfmm/attend/health-and-safety/

We are still looking into the virtual component.  We will likely run
something similar to what we did in 2022, but details on that will be
forthcoming.

2022: https://lwn.net/Articles/lsfmm2022/

2019:�https://lwn.net/Articles/lsfmm2019/

2018:�https://lwn.net/Articles/lsfmm2018/

2017:�https://lwn.net/Articles/lsfmm2017/

2016:�https://lwn.net/Articles/lsfmm2016/

2015:�https://lwn.net/Articles/lsfmm2015/

2014:�http://lwn.net/Articles/LSFMM2014/

3) If you have feedback on last year's meeting that we can use to
improve this year's, please also send that to:

� � � ��lsf-pc@lists.linux-foundation.org

Thank you on behalf of the program committee:

� � � � Josef Bacik (Filesystems)
� � � � Amir Goldstein (Filesystems)
� � � � Martin K. Petersen (Storage)
� � � � Javier Gonz�lez (Storage)
� � � � Michal Hocko (MM)
� � � � Dan Williams (MM)
� � � � Martin KaFai Lau (BPF)
� � � � Daniel Borkmann (BPF)
