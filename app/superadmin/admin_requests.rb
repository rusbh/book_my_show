ActiveAdmin.register(AdminRequest) do
  remove_filter :business_license_attachment,
                :business_license_blob,
                :ownership_proof_attachment,
                :ownership_proof_blob,
                :noc_attachment,
                :noc_blob,
                :insurance_attachment,
                :insurance_blob,
                :cpics_attachments,
                :cpics_blobs

  show do
    attributes_table do
      row :contact_email
      row :contact_no
      row :admin_emails
      row :theater_name
      row :theater_address
      row :pincode
      row :business_license do |p|
        if p.business_license.previewable?
          image_tag url_for(p.business_license.representation(resize: "500x500"))
        else
          link_to p.business_license.filename,
                  rails_blob_path(p.business_license, disposition: "attachment")
        end
      end
      row :ownership_proof do |p|
        if p.ownership_proof.previewable?
          image_tag url_for(p.ownership_proof.representation(resize: "500x500"))
        else
          link_to p.ownership_proof.filename,
                  rails_blob_path(p.ownership_proof, disposition: "attachment")
        end
      end
      row :noc do |p|
        if p.noc.previewable?
          image_tag url_for(p.noc.representation(resize: "500x500"))
        else
          link_to p.noc.filename,
                  rails_blob_path(p.noc, disposition: "attachment")
        end
      end
      row :insurance do |p|
        if p.insurance.previewable?
          image_tag url_for(p.insurance.representation(resize: "500x500"))
        else
          link_to p.insurance.filename,
                  rails_blob_path(p.insurance, disposition: "attachment")
        end
      end
      row :status
    end
  end

  form decorate: true do |f|
    f.inputs do
      f.input(:contact_email)
      f.input(:contact_no)
      f.input(:admin_emails)
      f.input(:theater_name)
      f.input(:theater_address)
      f.input(:pincode)
      f.input(
        :business_license,
        as: :file,
        input_html: { accept: "application/pdf, application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document" },
      )
      f.input(
        :ownership_proof,
        as: :file,
        input_html: { accept: "application/pdf, application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document" },
      )
      f.input(
        :noc,
        as: :file,
        input_html: { accept: "application/pdf, application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document" },
      )
      f.input(
        :insurance,
        as: :file,
        input_html: { accept: "application/pdf, application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document" },
      )
      f.input(:status)
    end
    f.actions
  end

  permit_params :contact_email,
                :contact_no,
                :admin_emails,
                :theater_name,
                :theater_address,
                :pincode,
                :business_license,
                :ownership_proof,
                :noc,
                :insurance,
                :status
end
