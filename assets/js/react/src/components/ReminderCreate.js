import React from 'react'
import { useMutation } from 'urql'
import { useHistory } from "react-router-dom"


const CreateReminderMutation = `
    mutation CreateReminder($params: ReminderParams!) {
        createReminder(params: $params) {
        title
        reminderGroupId
        }
    }
`

const ReminderCreate = (props) => {

    const [title, setTitle] = React.useState('')

    const [state, executeMutation] = useMutation(CreateReminderMutation)

    const redirectToReminderList = () => {
        let history = useHistory();
        history.push("/app/reminders");
    }

    const submit = React.useCallback(() => {
        console.log("---");
        console.log(title);
        executeMutation({ params: {title} }).then(( ) => {
            props.history.push("/app/reminders")
        })
    }, [executeMutation, title])

    return (
        <div>
            <label className="block uppercase tracking-wide text-grey-darker text-xs font-bold mb-2">Title</label>
            <input type="text" value={title} onChange={e => setTitle(e.target.value)} className="appearance-none block w-full bg-grey-lighter text-grey-darker border border-grey-lighter rounded py-3 px-4"></input>
            <button type="submit" className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" onClick={submit}>Save</button>
        </div>
    );

}


export default ReminderCreate;